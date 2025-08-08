import betamine/common/entity/entity_pose
import betamine/common/text_component
import betamine/common/uuid
import betamine/protocol/common/direction
import betamine/protocol/common/particle
import gleam/option
import nbeet

pub type MetadataDataType {
  Byte(Int)
  VarInt(Int)
  VarLong(Int)
  Float(Float)
  String(String)
  TextComponent(text_component.TextComponent)
  OptionalTextComponent(option.Option(text_component.TextComponent))
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

pub fn get_index(data_type: MetadataDataType) {
  case data_type {
    Byte(..) -> 0
    VarInt(..) -> 1
    VarLong(..) -> 2
    Float(..) -> 3
    String(..) -> 4
    TextComponent(..) -> 5
    OptionalTextComponent(..) -> 6
    Slot -> 7
    Boolean(..) -> 8
    Rotations(..) -> 9
    Position -> 10
    OptionalPosition -> 11
    Direction(..) -> 12
    OptionalLivingEntityReference(..) -> 13
    BlockState -> 14
    OptionalBlockState(..) -> 15
    NBT(..) -> 16
    Particle(..) -> 17
    Particles(..) -> 18
    VillagerData(..) -> 18
    OptionalVarInt(..) -> 19
    Pose(..) -> 20
    CatVariant(..) -> 21
    WolfVariant(..) -> 22
    FrogVariant(..) -> 23
    OptionalGlobalPosition -> 24
    PaintingVariant -> 25
    SnifferState -> 26
    AramdilloState -> 27
    Vector3(..) -> 28
    Quaternion(..) -> 29
  }
}
