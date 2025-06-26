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

fn get_byte(metadata: Metadata, index: Int) {
  use value <- result.try(dict.get(metadata.values, index))
  case value {
    metadata_data_type.Byte(int) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn get_bit(metadata: Metadata, index: Int, bitmask: Int) {
  use value <- result.try(get_byte(metadata, index))
  Ok(int.bitwise_and(value, bitmask) != 0)
}

fn set_byte(metadata: Metadata, index: Int, byte: Int) {
  use current <- result.try(dict.get(metadata.values, index))
  case current {
    metadata_data_type.Byte(_) -> {
      let values =
        dict.insert(metadata.values, index, metadata_data_type.Byte(byte))
      let dirty = set.insert(metadata.dirty, index)
      Ok(Metadata(values:, dirty:))
    }
    _ -> Error(Nil)
  }
}

fn set_bit(metadata: Metadata, index: Int, bitmask: Int, value: Bool) {
  use current <- result.try(get_byte(metadata, 0))
  let value = case value {
    True -> int.bitwise_or(current, bitmask)
    False -> int.bitwise_exclusive_or(current, bitmask)
  }
  set_byte(metadata, index, value)
}

pub fn get_on_fire(metadata: Metadata) {
  get_bit(metadata, 0, 0b00000001)
}

pub fn set_on_fire(metadata: Metadata, value: Bool) {
  set_bit(metadata, 0, 0b00000001, value)
}

pub fn get_sneaking(metadata: Metadata) {
  get_bit(metadata, 0, 0b00000010)
}

pub fn set_sneaking(metadata: Metadata, value: Bool) {
  set_bit(metadata, 0, 0b00000010, value)
}

pub fn get_sprinting(metadata: Metadata) {
  get_bit(metadata, 0, 0b00001000)
}

pub fn set_sprinting(metadata: Metadata, value: Bool) {
  set_bit(metadata, 0, 0b00001000, value)
}

pub fn get_swimming(metadata: Metadata) {
  get_bit(metadata, 0, 0b00010000)
}

pub fn set_swimming(metadata: Metadata, value: Bool) {
  set_bit(metadata, 0, 0b00010000, value)
}

pub fn get_invisible(metadata: Metadata) {
  get_bit(metadata, 0, 0b00100000)
}

pub fn set_invisible(metadata: Metadata, value: Bool) {
  set_bit(metadata, 0, 0b00100000, value)
}

pub fn get_glowing(metadata: Metadata) {
  get_bit(metadata, 0, 0b01000000)
}

pub fn set_glowing(metadata: Metadata, value: Bool) {
  set_bit(metadata, 0, 0b01000000, value)
}

pub fn get_gliding(metadata: Metadata) {
  get_bit(metadata, 0, 0b10000000)
}

pub fn set_gliding(metadata: Metadata, value: Bool) {
  set_bit(metadata, 0, 0b10000000, value)
}

fn get_var_int(metadata: Metadata, index: Int) {
  use value <- result.try(dict.get(metadata.values, index))
  case value {
    metadata_data_type.VarInt(int) -> Ok(int)
    _ -> Error(Nil)
  }
}

pub fn get_air_ticks(metadata: Metadata) {
  get_var_int(metadata, 1)
}

fn default_entity() {
  [
    EntityBitMask(False, False, False, False, False, False, False),
    AirTicks(300),
    CustomName(option.None),
    CustomNameVisible(False),
    Silent(False),
    Weightless(False),
    Pose(entity_pose.Standing),
    PowderedSnowTicks(0),
  ]
}

pub fn new() {
  s
  default_entity()
  |> list.map(fn(value) { #(get_index(value), value) })
  |> dict.from_list
  |> Metadata(set.new())
}

pub fn main() {
  let metadata = new()
  get_on_fire(metadata)
}
