import betamine/common/entity.{type Entity}
import betamine/common/entity_type
import betamine/common/metadata
import betamine/common/player.{type Player}
import betamine/common/uuid
import betamine/common/vector3
import betamine/constants
import betamine/game/command.{type Command}
import betamine/game/update.{type Update}
import betamine/mojang/api as mojang_api
import betamine/protocol/common/entity_animation
import gleam/dict
import gleam/erlang/process.{type Subject}
import gleam/function
import gleam/list
import gleam/otp/actor
import gleam/pair
import gleam/set

type Game {
  Game(
    sessions: dict.Dict(uuid.Uuid, #(Subject(Update), Player)),
    entities: dict.Dict(Int, Entity),
  )
}

pub fn start() -> Result(Subject(Command), actor.StartError) {
  let start_result =
    actor.new(Game(sessions: dict.new(), entities: dict.new()))
    |> actor.on_message(loop)
    |> actor.start()

  case start_result {
    Ok(started) -> Ok(started.data)
    Error(err) -> Error(err)
  }
}

fn loop(game: Game, command: Command) -> actor.Next(Game, Command) {
  case command {
    command.GetAllPlayers(subject) -> {
      dict.values(game.sessions)
      |> list.map(pair.second)
      |> list.map(fn(player) {
        case dict.get(game.entities, player.entity_id) {
          Ok(entity) -> #(player, entity)
          Error(_) -> #(player, entity.default)
        }
      })
      |> process.send(subject, _)
      actor.continue(game)
    }
    command.SpawnPlayer(subject, player_subject, uuid, name) -> {
      let assert Ok(profile) = mojang_api.fetch_profile(uuid)
      let entity =
        entity.Entity(
          ..entity.default,
          id: dict.size(game.entities),
          uuid:,
          entity_type: entity_type.Player,
          position: constants.mc_player_spawn_point,
        )
      let player =
        player.Player(
          name,
          uuid,
          entity.id,
          profile,
          metadata.default_player_metadata,
        )
      process.send(player_subject, #(player, entity))
      update_sessions(game, update.PlayerSpawned(player, entity))
      actor.continue(Game(
        sessions: dict.insert(game.sessions, player.uuid, #(subject, player)),
        entities: dict.insert(game.entities, entity.id, entity),
      ))
    }
    command.MoveEntity(entity_id, new_position, on_ground) -> {
      let entity = case dict.get(game.entities, entity_id) {
        Ok(entity) -> {
          let old_position = entity.position
          let entity = case vector3.equal(old_position, new_position) {
            True -> entity
            False -> {
              update_sessions(
                game,
                update.EntityPosition(
                  entity.id,
                  vector3.subtract(new_position, old_position),
                  on_ground,
                ),
              )
              entity.Entity(..entity, position: new_position)
            }
          }
          entity
        }
        Error(_) -> todo
      }
      actor.continue(
        Game(..game, entities: dict.insert(game.entities, entity.id, entity)),
      )
    }
    command.RotateEntity(entity_id, rotation, on_ground) -> {
      let entity = case dict.get(game.entities, entity_id) {
        Ok(entity) -> {
          update_sessions(
            game,
            update.EntityRotation(entity.id, rotation, on_ground),
          )
          entity.Entity(..entity, rotation:)
        }
        Error(_) -> todo
      }
      actor.continue(
        Game(..game, entities: dict.insert(game.entities, entity.id, entity)),
      )
    }
    command.RemovePlayer(uuid, _subject) -> {
      let session = dict.get(game.sessions, uuid)
      let game = case session {
        Error(_) -> game
        Ok(#(_subject, player)) -> {
          update_sessions(game, update.PlayerDisconnected(player))
          Game(
            sessions: dict.delete(game.sessions, uuid),
            entities: dict.delete(game.entities, player.entity_id),
          )
        }
      }

      actor.continue(game)
    }
    command.UpdatePlayerMetadata(uuid, metadata) -> {
      let session = dict.get(game.sessions, uuid)
      let game = case session {
        Error(_) -> game
        Ok(#(subject, player)) -> {
          let player = player.Player(..player, metadata:)
          update_sessions(game, update.PlayerMetadataUpdated(player))
          Game(
            sessions: dict.insert(game.sessions, uuid, #(subject, player)),
            entities: game.entities,
          )
        }
      }
      actor.continue(game)
    }
    command.SwingPlayerArm(uuid, is_dominant) -> {
      let session = dict.get(game.sessions, uuid)
      case session {
        Error(_) -> Nil
        Ok(#(_, player)) -> {
          let animation = case is_dominant {
            True -> entity_animation.SwingDominantArm
            False -> entity_animation.SwingNonDominantArm
          }
          update_other_sessions(
            game,
            player.uuid,
            update.EntityAnimation(player.entity_id, animation),
          )
        }
      }
      actor.continue(game)
    }
    command.Tick -> actor.continue(game)
    command.Shutdown -> todo
  }
}

fn update_sessions(game: Game, update: update.Update) {
  game.sessions
  |> dict.values
  |> list.each(fn(session) { process.send(session.0, update) })
}

fn update_other_sessions(
  game: Game,
  current_uuid: uuid.Uuid,
  update: update.Update,
) {
  game.sessions
  |> dict.values
  |> list.each(fn(session) {
    case uuid.is_equal(current_uuid, { session.1 }.uuid) {
      True -> Nil
      False -> process.send(session.0, update)
    }
  })
}
