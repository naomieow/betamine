import betamine/common/uuid

pub type Player {
  Player(name: String, uuid: uuid.Uuid, entity_id: Int)
}
