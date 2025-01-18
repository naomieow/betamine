import betamine/common/entity_type.{type EntityType}
import betamine/common/rotation.{type Rotation, Rotation}
import betamine/common/uuid
import betamine/common/vector3.{type Vector3, Vector3}

pub type Entity {
  Entity(
    id: Int,
    uuid: uuid.Uuid,
    entity_type: EntityType,
    position: Vector3(Float),
    rotation: Rotation,
    head_rotation: Float,
    velocity: Vector3(Float),
  )
}

pub const default = Entity(
  id: 0,
  uuid: uuid.default,
  entity_type: entity_type.Player,
  position: Vector3(0.0, 0.0, 0.0),
  rotation: Rotation(0.0, 0.0),
  head_rotation: 0.0,
  velocity: Vector3(0.0, 0.0, 0.0),
)
