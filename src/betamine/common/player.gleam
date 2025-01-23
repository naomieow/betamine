import betamine/common/metadata
import betamine/common/profile
import betamine/common/uuid

pub type Player {
  Player(
    name: String,
    uuid: uuid.Uuid,
    entity_id: Int,
    profile: profile.Profile,
    metadata: metadata.PlayerMetadata,
  )
}

pub const default = Player(
  "",
  uuid.default,
  0,
  profile.default,
  metadata.default_player_metadata,
)
