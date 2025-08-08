import betamine/common/entity/entity_pose
import betamine/protocol/common/entity/metadata/metadata_data_type
import gleam/dict
import gleam/int
import gleam/list
import gleam/option
import gleam/result
import gleam/set

pub opaque type Metadata {
  Metadata(
    values: dict.Dict(Int, metadata_data_type.MetadataDataType),
    dirty: set.Set(Int),
  )
}

fn with_value(
  metadata: Metadata,
  index: Int,
  value: metadata_data_type.MetadataDataType,
) {
  let values = dict.insert(metadata.values, index, value)
  let dirty = set.insert(metadata.dirty, index)
  Ok(Metadata(values:, dirty:))
}

fn byte(metadata: Metadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(metadata_data_type.Byte(int)) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn bit(metadata: Metadata, index: Int, bitmask: Int) {
  use value <- result.try(byte(metadata, index))
  Ok(int.bitwise_and(value, bitmask) != 0)
}

fn with_byte(metadata: Metadata, index: Int, byte: Int) {
  use current <- result.try(dict.get(metadata.values, index))
  case current {
    metadata_data_type.Byte(_) ->
      with_value(metadata, index, metadata_data_type.Byte(byte))
    _ -> Error(Nil)
  }
}

fn with_bit(metadata: Metadata, index: Int, bitmask: Int, value: Bool) {
  use current <- result.try(byte(metadata, 0))
  let value = case value {
    True -> int.bitwise_or(current, bitmask)
    False -> int.bitwise_exclusive_or(current, bitmask)
  }
  with_byte(metadata, index, value)
}

pub fn on_fire(metadata: Metadata) {
  bit(metadata, 0, 0b00000001)
}

pub fn with_on_fire(metadata: Metadata, value: Bool) {
  with_bit(metadata, 0, 0b00000001, value)
}

pub fn sneaking(metadata: Metadata) {
  bit(metadata, 0, 0b00000010)
}

pub fn with_sneaking(metadata: Metadata, value: Bool) {
  with_bit(metadata, 0, 0b00000010, value)
}

pub fn sprinting(metadata: Metadata) {
  bit(metadata, 0, 0b00001000)
}

pub fn with_sprinting(metadata: Metadata, value: Bool) {
  with_bit(metadata, 0, 0b00001000, value)
}

pub fn swimming(metadata: Metadata) {
  bit(metadata, 0, 0b00010000)
}

pub fn with_swimming(metadata: Metadata, value: Bool) {
  with_bit(metadata, 0, 0b00010000, value)
}

pub fn invisible(metadata: Metadata) {
  bit(metadata, 0, 0b00100000)
}

pub fn with_invisible(metadata: Metadata, value: Bool) {
  with_bit(metadata, 0, 0b00100000, value)
}

pub fn glowing(metadata: Metadata) {
  bit(metadata, 0, 0b01000000)
}

pub fn with_glowing(metadata: Metadata, value: Bool) {
  with_bit(metadata, 0, 0b01000000, value)
}

pub fn gliding(metadata: Metadata) {
  bit(metadata, 0, 0b10000000)
}

pub fn with_gliding(metadata: Metadata, value: Bool) {
  with_bit(metadata, 0, 0b10000000, value)
}

fn var_int(metadata: Metadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(metadata_data_type.VarInt(int)) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn with_var_int(metadata: Metadata, index: Int, var_int: Int) {
  case dict.get(metadata.values, index) {
    Ok(metadata_data_type.VarInt(_)) ->
      with_value(metadata, index, metadata_data_type.VarInt(var_int))
    _ -> Error(Nil)
  }
}

pub fn air_ticks(metadata: Metadata) {
  var_int(metadata, 1)
}

pub fn with_air_ticks(metadata: Metadata, var_int: Int) {
  with_var_int(metadata, 1, var_int)
}


pub fn with_custom_name(metadata: Metadata, option: option.Option(String)) {
  todo
}
// fn default_entity() {
//   [
//     EntityBitMask(False, False, False, False, False, False, False),
//     AirTicks(300),
//     CustomName(option.None),
//     CustomNameVisible(False),
//     Silent(False),
//     Weightless(False),
//     Pose(entity_pose.Standing),
//     PowderedSnowTicks(0),
//   ]
// }

// pub fn new() {
//   s
//   default_entity()
//   |> list.map(fn(value) { #(index(value), value) })
//   |> dict.from_list
//   |> Metadata(set.new())
// }

// pub fn main() {
//   let metadata = new()
//   on_fire(metadata)
// }
