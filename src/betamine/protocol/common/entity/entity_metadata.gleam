import betamine/common/entity/entity_pose
import betamine/common/global_position
import betamine/common/position
import betamine/common/slot
import betamine/common/text_component
import betamine/common/uuid
import betamine/protocol/common/direction
import betamine/protocol/common/particle
import betamine/protocol/encoder
import gleam/bytes_tree
import gleam/dict
import gleam/option
import nbeet

pub type Metadata =
  dict.Dict(Int, DataType)

pub type DataType {
  Byte(Int)
  VarInt(Int)
  VarLong(Int)
  Float(Float)
  String(String)
  TextComponent(text_component.TextComponent)
  OptionalTextComponent(option.Option(text_component.TextComponent))
  Slot(slot.Slot)
  Boolean(Bool)
  Rotations(x: Float, y: Float, z: Float)
  Position(position.Position)
  OptionalPosition(option.Option(position.Position))
  Direction(direction.Direction)
  OptionalLivingEntityReference(option.Option(uuid.Uuid))
  BlockState
  OptionalBlockState(option.Option(Nil))
  NBT(nbeet.Nbt)
  Particle(particle.Particle)
  Particles(List(particle.Particle))
  VillagerData(villager_type: Int, villager_profession: Int, level: Int)
  OptionalVarInt(option.Option(Int))
  Pose(entity_pose.EntityPose)
  CatVariant(Int)
  WolfVariant(Int)
  FrogVariant(Int)
  OptionalGlobalPosition(option.Option(global_position.GlobalPosition))
  PaintingVariant
  SnifferState
  AramdilloState
  Vector3(Float, Float, Float)
  Quaternion(Float, Float, Float, Float)
}

pub fn to_type_int(data_type: DataType) {
  case data_type {
    Byte(..) -> 0
    VarInt(..) -> 1
    VarLong(..) -> 2
    Float(..) -> 3
    String(..) -> 4
    TextComponent(..) -> 5
    OptionalTextComponent(..) -> 6
    Slot(..) -> 7
    Boolean(..) -> 8
    Rotations(..) -> 9
    Position(..) -> 10
    OptionalPosition(..) -> 11
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
    OptionalGlobalPosition(..) -> 24
    PaintingVariant -> 25
    SnifferState -> 26
    AramdilloState -> 27
    Vector3(..) -> 28
    Quaternion(..) -> 29
  }
}

pub fn encode(bytes_tree: bytes_tree.BytesTree, metadata: Metadata) {
  dict.fold(metadata, bytes_tree, fn(bytes_tree, index, data_type) {
    bytes_tree
    |> encoder.byte(index)
    |> encoder.var_int(to_type_int(data_type))
    |> encode_data_type(data_type)
  })
  |> encoder.byte(0xff)
}

fn encode_data_type(bytes_tree: bytes_tree.BytesTree, data_type: DataType) {
  bytes_tree
  |> case data_type {
    Byte(byte) -> encoder.byte(_, byte)
    VarInt(var_int) -> encoder.var_int(_, var_int)
    VarLong(_) -> todo
    Float(float) -> encoder.float(_, float)
    String(string) -> encoder.string(_, string)
    TextComponent(_) -> todo
    OptionalTextComponent(_) -> todo
    Slot(_) -> todo
    Boolean(bool) -> encoder.bool(_, bool)
    Rotations(_, _, _) -> todo
    Position(_) -> todo
    OptionalPosition(_) -> todo
    Direction(_) -> todo
    OptionalLivingEntityReference(_) -> todo
    BlockState -> todo
    OptionalBlockState(_) -> todo
    NBT(_) -> todo
    Particle(_) -> todo
    Particles(_) -> todo
    VillagerData(_, _, _) -> todo
    OptionalVarInt(_) -> todo
    Pose(pose) -> encoder.var_int(_, entity_pose.to_int(pose))
    CatVariant(_) -> todo
    WolfVariant(_) -> todo
    FrogVariant(_) -> todo
    OptionalGlobalPosition(_) -> todo
    PaintingVariant -> todo
    SnifferState -> todo
    AramdilloState -> todo
    Vector3(_, _, _) -> todo
    Quaternion(_, _, _, _) -> todo
  }
}
