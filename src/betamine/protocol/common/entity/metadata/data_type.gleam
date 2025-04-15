import betamine/common/uuid
import betamine/protocol/common/direction
import betamine/protocol/common/entity/entity_pose
import betamine/protocol/common/particle
import gleam/option
import nbeet

pub type DataType {
  Byte(Int)
  VarInt(Int)
  VarLong(Int)
  Float(Float)
  String(String)
  TextComponent
  OptionalTextComponent(option.Option(Nil))
  Slot
  Boolean(Bool)
  Rotations(x: Float, y: Float, z: Float)
  Position
  OptionalPosition
  Direction(direction.Direction)
  OptionalLivingEntityReference(option.Option(uuid.Uuid))
  BlockState
  OptionalBlockState(option.Option(Nil))
  NBT(nbeet.Nbt)
  Particle(particle.Particle)
  Particles(List(particle.Particle))
  VillagerData(villager_type: Int, villager_profession: Int, level: Int)
  OptionalVarInt(Int)
  Pose(entity_pose.EntityPose)
  CatVariant(Int)
  WolfVariant(Int)
  FrogVariant(Int)
  OptionalGlobalPosition
  PaintingVariant
  SnifferState
  AramdilloState
  Vector3(Float, Float, Float)
  Quaternion(Float, Float, Float, Float)
}
