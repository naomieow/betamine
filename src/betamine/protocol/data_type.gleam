import betamine/common/identifier
import betamine/common/uuid
import betamine/common/vector3
import gleam/option

pub type DataType {
  Boolean(Bool)
  Byte(Int)
  UnsignedByte(Int)
  Short(Int)
  UnsignedShort(Int)
  Int(Int)
  Long(Int)
  Float(Float)
  Double(Float)
  String(String)
  Identifier(identifier.Identifier)
  VarInt(Int)
  VarLong(Int)
  Position(vector3.Vector3(Int))
  Angle(Int)
  Uuid(uuid.Uuid)
  Optional(option.Option(DataType))
  PrefixedOptional(option.Option(DataType))
  Array(List(DataType))
  PrefixedArray(List(DataType))
  Enum(DataType)
  BitSet(List(Int))
  FixedBitSet(length: Int, bits: List(Int))
  ByteArray(BitArray)
}
