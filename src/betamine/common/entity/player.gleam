import betamine/common/entity
import betamine/common/entity/entity_kind
import betamine/common/profile
import betamine/common/uuid

pub type Player {
  Player(name: String, entity: entity.Entity, profile: profile.Profile)
}

pub fn new() {
  Player("", entity: entity.new(entity_kind.Player), profile: profile.default())
}

pub fn with_uuid(player: Player, uuid: uuid.Uuid) {
  Player(..player, entity: entity.with_uuid(player.entity, uuid))
}
