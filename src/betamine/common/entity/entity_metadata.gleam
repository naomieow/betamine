import betamine/common/entity/entity_hand
import betamine/common/entity/entity_handedness
import betamine/common/entity/entity_kind
import betamine/common/entity/entity_pose
import betamine/common/entity/player/player_model_customization
import betamine/common/math/vector3
import gleam/dict
import gleam/list
import gleam/option
import gleam/set
import nbeet

pub opaque type EntityMetadata {
  EntityMetadata(values: dict.Dict(Int, Value), dirty: set.Set(Int))
}

pub type Value {
  // Entity
  EntityBitMask(
    on_fire: Bool,
    sneaking: Bool,
    sprinting: Bool,
    swimming: Bool,
    invisible: Bool,
    glowing: Bool,
    gliding: Bool,
  )
  AirTicks(Int)
  CustomName(option.Option(String))
  CustomNameVisible(Bool)
  Silent(Bool)
  Weightless(Bool)
  Pose(entity_pose.EntityPose)
  PowderedSnowTicks(Int)
  // Living Entity
  LivingEntityBitMask(
    hand_active: Bool,
    active_hand: entity_hand.EntityHand,
    spin_attacking: Bool,
  )
  Health(Float)
  PotionEffectColor(List(Nil))
  AmbientPotionEffect(Bool)
  ArrowCount(Int)
  BeeStingerCount(Int)
  SleepingPosition(option.Option(vector3.Vector3(Float)))
  // Player
  AdditionalHearts(Float)
  Score(Int)
  ModelCustomization(player_model_customization.PlayerModelCustomization)
  MainHand(entity_handedness.EntityHandedness)
  LeftShoulderEntityData(nbeet.Nbt)
  RightShoulderEntityData(nbeet.Nbt)
  // Mob
  MobBitMask(no_ai: Bool, left_handed: Bool, agressive: Bool)
  // Ageable Mob
  Baby(Bool)
  // Pig
  BoostTime(Int)
}

pub fn get_index(value: Value) {
  case value {
    EntityBitMask(..) -> 0
    AirTicks(..) -> 1
    CustomName(..) -> 2
    CustomNameVisible(..) -> 3
    Silent(..) -> 4
    Weightless(..) -> 5
    Pose(..) -> 6
    PowderedSnowTicks(..) -> 7
    LivingEntityBitMask(..) -> 8
    Health(..) -> 9
    PotionEffectColor(..) -> 10
    AmbientPotionEffect(..) -> 11
    ArrowCount(..) -> 12
    BeeStingerCount(..) -> 13
    SleepingPosition(..) -> 14
    AdditionalHearts(..) | MobBitMask(..) -> 15
    Score(..) | Baby(..) -> 16
    ModelCustomization(..) | BoostTime(..) -> 17
    MainHand(..) -> 18
    LeftShoulderEntityData(..) -> 19
    RightShoulderEntityData(..) -> 20
  }
}

pub fn new(kind: entity_kind.EntityKind) {
  case kind {
    entity_kind.Player -> default_player()
    entity_kind.Pig -> default_pig()
    _ -> []
  }
  |> list.map(fn(value) { #(get_index(value), value) })
  |> dict.from_list
  |> EntityMetadata(set.new())
}

fn default_entity() {
  [
    EntityBitMask(False, False, False, False, False, False, False),
    AirTicks(300),
    CustomName(option.None),
    CustomNameVisible(False),
    Silent(False),
    Weightless(False),
    Pose(entity_pose.Standing),
    PowderedSnowTicks(0),
  ]
}

fn default_living_entity() {
  [
    LivingEntityBitMask(False, entity_hand.Dominant, False),
    Health(1.0),
    PotionEffectColor([]),
    AmbientPotionEffect(False),
    ArrowCount(0),
    BeeStingerCount(0),
    SleepingPosition(option.None),
    ..default_entity()
  ]
}

fn default_player() {
  [
    AdditionalHearts(0.0),
    Score(0),
    ModelCustomization(player_model_customization.default()),
    MainHand(entity_handedness.Right),
    LeftShoulderEntityData(nbeet.empty),
    RightShoulderEntityData(nbeet.empty),
    ..default_living_entity()
  ]
}

fn default_mob() {
  [MobBitMask(False, False, False), ..default_living_entity()]
}

fn default_creature() {
  default_mob()
}

fn default_ageable_mob() {
  [Baby(False), ..default_creature()]
}

fn default_animal() {
  default_ageable_mob()
}

fn default_pig() {
  [BoostTime(0), ..default_animal()]
}

// pub fn get(metadata: EntityMetadata, value: Value) {
//   dict.has_key
//   dict.get(metadata.values, index)
// }

pub fn set(metadata: EntityMetadata, value: Value) {
  todo
}

pub fn get_on_fire(metadata: EntityMetadata) {
  let result = dict.get(metadata.values, 0)
  case result {
    Ok(value) -> {
      case value {
        EntityBitMask(on_fire:, ..) -> on_fire
        _ -> False
      }
    }
    Error(_) -> False
  }
}
