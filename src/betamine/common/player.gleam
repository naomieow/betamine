import betamine/common/profile
import betamine/common/uuid
import betamine/protocol/common/entity/entity_metadata

pub type Player {
  Player(
    name: String,
    uuid: uuid.Uuid,
    entity_id: Int,
    profile: profile.Profile,
    metadata: entity_metadata.PlayerMetadata,
  )
}

pub fn default() {
  Player(
    "",
    uuid.default,
    0,
    profile.default,
    entity_metadata.default_player_metadata(),
  )
}
