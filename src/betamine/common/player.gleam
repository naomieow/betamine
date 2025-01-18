import betamine/common/profile
import betamine/common/uuid

pub type Player {
  Player(
    name: String,
    uuid: uuid.Uuid,
    entity_id: Int,
    profile: profile.Profile,
  )
}
