import betamine/common/text_component
import betamine/protocol/common/entity/metadata/metadata_data_type
import gleam/dict
import gleam/int
import gleam/option
import gleam/result
import gleam/set

pub opaque type Metadata {
  Metadata(
    values: dict.Dict(Int, metadata_data_type.MetadataDataType),
    dirty: set.Set(Int),
  )
}

pub type MetadataIndex {
  Index(value: Int)
  BitmaskIndex(value: Int, bit_mask: Int)
}

pub opaque type MetadataAccessor(value) {
  // MetadataAccessor(
  //   index: MetadataIndex,
  //   getter: fn(Metadata, MetadataIndex) -> Result(value, Nil),
  //   setter: fn(Metadata, MetadataIndex, value) -> Result(Metadata, Nil),
  // )
  MetadataAccessor(
    index: MetadataIndex,
    matcher: fn(metadata_data_type.MetadataDataType) -> value,
    converter: fn(value) -> metadata_data_type.MetadataDataType,
  )
}

pub fn set(metadata: Metadata, accessor: MetadataAccessor(value), value: value) {
  accessor.setter(metadata, value)
}

fn set_value(
  metadata: Metadata,
  index: Int,
  value: metadata_data_type.MetadataDataType,
) {
  let values = dict.insert(metadata.values, index, value)
  let dirty = set.insert(metadata.dirty, index)
  Ok(Metadata(values:, dirty:))
}

fn get_byte(metadata: Metadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(metadata_data_type.Byte(int)) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn set_byte(metadata: Metadata, index: Int, byte: Int) {
  case get_byte(metadata, index) {
    Ok(_) -> set_value(metadata, index, metadata_data_type.Byte(byte))
    _ -> Error(Nil)
  }
}

fn get_bit(metadata: Metadata, index: Int, bitmask: Int) {
  use value <- result.try(get_byte(metadata, index))
  Ok(int.bitwise_and(value, bitmask) != 0)
}

fn get_bit_1(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b00000001)
}

fn get_bit_2(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b00000010)
}

fn get_bit_3(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b00000100)
}

fn get_bit_4(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b00001000)
}

fn get_bit_5(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b00010000)
}

fn get_bit_6(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b00100000)
}

fn get_bit_7(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b01000000)
}

fn get_bit_8(metadata: Metadata, index: Int) {
  get_bit(metadata, index, 0b10000000)
}

fn set_bit(metadata: Metadata, index: Int, bitmask: Int, value: Bool) {
  use current <- result.try(get_byte(metadata, 0))
  let value = case value {
    True -> int.bitwise_or(current, bitmask)
    False -> int.bitwise_exclusive_or(current, bitmask)
  }
  set_byte(metadata, index, value)
}

fn set_bit_1(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00000001, value)
}

fn set_bit_2(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00000010, value)
}

fn set_bit_3(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00000100, value)
}

fn set_bit_4(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00001000, value)
}

fn set_bit_5(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00010000, value)
}

fn set_bit_6(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00100000, value)
}

fn set_bit_7(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b01000000, value)
}

fn set_bit_8(metadata: Metadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b10000000, value)
}

pub const on_fire = MetadataAccessor(0, get_bit_1, set_bit_1)

pub const sneaking = MetadataAccessor(0, get_bit_2, set_bit_2)

pub const sprinting = MetadataAccessor(0, get_bit_3, set_bit_3)

pub const swimming = MetadataAccessor(0, get_bit_4, set_bit_4)

pub const invisible = MetadataAccessor(0, get_bit_5, set_bit_5)

pub const glowing = MetadataAccessor(0, get_bit_6, set_bit_6)

pub const gliding = MetadataAccessor(0, get_bit_7, set_bit_7)

fn get_var_int(metadata: Metadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(metadata_data_type.VarInt(int)) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn set_var_int(metadata: Metadata, index: Int, var_int: Int) {
  case get_var_int(metadata, index) {
    Ok(_) -> set_value(metadata, index, metadata_data_type.VarInt(var_int))
    _ -> Error(Nil)
  }
}

pub const air_ticks = MetadataAccessor(1, get_var_int, set_var_int)

fn get_optional_text_component(metadata: Metadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(metadata_data_type.OptionalTextComponent(optional_text_component)) ->
      Ok(optional_text_component)
    _ -> Error(Nil)
  }
}

fn set_optional_text_component(
  metadata: Metadata,
  index: Int,
  optional_text_component: option.Option(text_component.TextComponent),
) {
  todo
}

pub const custom_name = MetadataAccessor(
  2,
  get_optional_text_component,
  set_optional_text_component,
)

fn get_boolean(metadata: Metadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(metadata_data_type.Boolean(bool)) -> Ok(bool)
    _ -> Error(Nil)
  }
}

fn set_boolean(metadata: Metadata, index: Int, boolean: Bool) {
  todo
}

pub const custom_name_visible = MetadataAccessor(3, get_boolean, set_boolean)

pub const silent = MetadataAccessor(3, get_boolean, set_boolean)

pub const weightless = MetadataAccessor(3, get_boolean, set_boolean)
