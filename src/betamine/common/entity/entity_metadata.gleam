import betamine/common/entity/entity_hand
import betamine/common/entity/entity_handedness
import betamine/common/entity/entity_kind
import betamine/common/entity/entity_pose
import betamine/common/particle
import betamine/common/position
import betamine/common/text_component
import betamine/protocol/common/entity/entity_metadata.{type DataType}
import gleam/dict
import gleam/int
import gleam/option
import gleam/result
import gleam/set
import nbeet

pub opaque type EntityMetadata {
  EntityMetadata(values: dict.Dict(Int, DataType), dirty: set.Set(Int))
}

pub opaque type MetadataAccessor(value) {
  MetadataAccessor(
    index: Int,
    getter: fn(EntityMetadata, Int) -> Result(value, Nil),
    setter: fn(EntityMetadata, Int, value) -> Result(EntityMetadata, Nil),
  )
}

pub fn set(
  metadata: EntityMetadata,
  accessor: MetadataAccessor(value),
  value: value,
) {
  accessor.setter(metadata, accessor.index, value)
}

pub fn get(metadata: EntityMetadata, accessor: MetadataAccessor(value)) {
  accessor.getter(metadata, accessor.index)
}

pub fn to_protocol(metadata: EntityMetadata) {
  set.fold(metadata.dirty, dict.new(), fn(dict, index) {
    case dict.get(metadata.values, index) {
      Ok(data_type) -> dict.insert(dict, index, data_type)
      Error(_) -> dict
    }
  })
}

pub fn clean(metadata: EntityMetadata) {
  EntityMetadata(metadata.values, set.new())
}

fn set_value(metadata: EntityMetadata, index: Int, value: DataType) {
  let values = dict.insert(metadata.values, index, value)
  let dirty = set.insert(metadata.dirty, index)
  Ok(EntityMetadata(values:, dirty:))
}

fn get_byte(metadata: EntityMetadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(entity_metadata.Byte(int)) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn set_byte(metadata: EntityMetadata, index: Int, byte: Int) {
  case get_byte(metadata, index) {
    Ok(_) -> set_value(metadata, index, entity_metadata.Byte(byte))
    _ -> Error(Nil)
  }
}

fn get_bit(metadata: EntityMetadata, index: Int, bitmask: Int) {
  use value <- result.try(get_byte(metadata, index))
  Ok(int.bitwise_and(value, bitmask) != 0)
}

fn get_bit_1(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b00000001)
}

fn get_bit_2(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b00000010)
}

fn get_bit_3(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b00000100)
}

fn get_bit_4(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b00001000)
}

fn get_bit_5(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b00010000)
}

fn get_bit_6(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b00100000)
}

fn get_bit_7(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b01000000)
}

fn get_bit_8(metadata: EntityMetadata, index: Int) {
  get_bit(metadata, index, 0b10000000)
}

fn set_bit(metadata: EntityMetadata, index: Int, bitmask: Int, value: Bool) {
  use current <- result.try(get_byte(metadata, 0))
  let value = case value {
    True -> int.bitwise_or(current, bitmask)
    False -> int.bitwise_exclusive_or(current, bitmask)
  }
  set_byte(metadata, index, value)
}

fn set_bit_1(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00000001, value)
}

fn set_bit_2(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00000010, value)
}

fn set_bit_3(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00000100, value)
}

fn set_bit_4(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00001000, value)
}

fn set_bit_5(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00010000, value)
}

fn set_bit_6(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b00100000, value)
}

fn set_bit_7(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b01000000, value)
}

fn set_bit_8(metadata: EntityMetadata, index: Int, value: Bool) {
  set_bit(metadata, index, 0b10000000, value)
}

fn get_float(metadata: EntityMetadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(entity_metadata.Float(int)) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn set_float(metadata: EntityMetadata, index: Int, float: Float) {
  case get_float(metadata, index) {
    Ok(_) -> set_value(metadata, index, entity_metadata.Float(float))
    _ -> Error(Nil)
  }
}

fn get_var_int(metadata: EntityMetadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(entity_metadata.VarInt(int)) -> Ok(int)
    _ -> Error(Nil)
  }
}

fn set_var_int(metadata: EntityMetadata, index: Int, var_int: Int) {
  case get_var_int(metadata, index) {
    Ok(_) -> set_value(metadata, index, entity_metadata.VarInt(var_int))
    _ -> Error(Nil)
  }
}

fn get_optional_text_component(metadata: EntityMetadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(entity_metadata.OptionalTextComponent(optional_text_component)) ->
      Ok(optional_text_component)
    _ -> Error(Nil)
  }
}

fn set_optional_text_component(
  metadata: EntityMetadata,
  index: Int,
  optional_text_component: option.Option(text_component.TextComponent),
) {
  todo
}

fn get_boolean(metadata: EntityMetadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(entity_metadata.Boolean(bool)) -> Ok(bool)
    _ -> Error(Nil)
  }
}

fn set_boolean(metadata: EntityMetadata, index: Int, boolean: Bool) {
  case get_boolean(metadata, index) {
    Ok(_) -> set_value(metadata, index, entity_metadata.Boolean(boolean))
    _ -> Error(Nil)
  }
}

fn get_pose(metadata: EntityMetadata, index: Int) {
  case dict.get(metadata.values, index) {
    Ok(entity_metadata.Pose(pose)) -> Ok(pose)
    _ -> Error(Nil)
  }
}

fn set_pose(metadata: EntityMetadata, index: Int, pose: entity_pose.EntityPose) {
  case get_pose(metadata, index) {
    Ok(_) -> set_value(metadata, index, entity_metadata.Pose(pose))
    _ -> Error(Nil)
  }
}

// Entity

pub const on_fire = MetadataAccessor(0, get_bit_1, set_bit_1)

pub const sneaking = MetadataAccessor(0, get_bit_2, set_bit_2)

pub const sprinting = MetadataAccessor(0, get_bit_3, set_bit_3)

pub const swimming = MetadataAccessor(0, get_bit_4, set_bit_4)

pub const invisible = MetadataAccessor(0, get_bit_5, set_bit_5)

pub const glowing = MetadataAccessor(0, get_bit_6, set_bit_6)

pub const gliding = MetadataAccessor(0, get_bit_7, set_bit_7)

pub const air_ticks = MetadataAccessor(1, get_var_int, set_var_int)

pub const custom_name = MetadataAccessor(
  2,
  get_optional_text_component,
  set_optional_text_component,
)

pub const custom_name_visible = MetadataAccessor(3, get_boolean, set_boolean)

pub const silent = MetadataAccessor(4, get_boolean, set_boolean)

pub const weightless = MetadataAccessor(5, get_boolean, set_boolean)

pub const pose = MetadataAccessor(6, get_pose, set_pose)

pub const powdered_snow_ticks = MetadataAccessor(7, get_var_int, set_var_int)

// Living Entity

pub const hand_active = MetadataAccessor(8, get_bit_1, set_bit_1)

fn get_entity_hand(metadata: EntityMetadata, index: Int) {
  case get_bit_2(metadata, index) {
    Ok(True) -> Ok(entity_hand.NonDominant)
    Ok(False) -> Ok(entity_hand.Dominant)
    _ -> Error(Nil)
  }
}

fn set_entity_hand(
  metadata: EntityMetadata,
  index: Int,
  hand: entity_hand.EntityHand,
) {
  case hand {
    entity_hand.Dominant -> False
    entity_hand.NonDominant -> True
  }
  |> set_bit_2(metadata, index, _)
}

pub const active_hand = MetadataAccessor(8, get_entity_hand, set_entity_hand)

pub const spin_attacking = MetadataAccessor(8, get_bit_3, set_bit_3)

pub const health = MetadataAccessor(9, get_float, set_float)

fn get_particles(metadata: EntityMetadata, index: Int) {
  todo
}

fn set_particles(
  metadata: EntityMetadata,
  index: Int,
  particles: List(particle.Particle),
) {
  todo
}

pub const potion_effect_color = MetadataAccessor(
  10,
  get_particles,
  set_particles,
)

pub const is_potion_effect_ambient = MetadataAccessor(
  11,
  get_boolean,
  set_boolean,
)

pub const impaled_arrow_count = MetadataAccessor(12, get_var_int, set_var_int)

pub const impaled_stinger_count = MetadataAccessor(13, get_var_int, set_var_int)

pub fn get_optional_position(metadata: EntityMetadata, index: Int) {
  todo
}

pub fn set_optional_position(
  metadata: EntityMetadata,
  index: Int,
  position: option.Option(position.Position),
) {
  todo
}

pub const current_sleeping_bed_position = MetadataAccessor(
  14,
  get_optional_position,
  set_optional_position,
)

// Player

pub const additional_hearts = MetadataAccessor(15, get_float, set_float)

pub const score = MetadataAccessor(16, get_var_int, set_var_int)

pub const cape_enabled = MetadataAccessor(17, get_bit_1, set_bit_1)

pub const jacket_enabled = MetadataAccessor(17, get_bit_2, set_bit_2)

pub const left_sleeve_enabled = MetadataAccessor(17, get_bit_3, set_bit_3)

pub const right_sleeve_enabled = MetadataAccessor(17, get_bit_4, set_bit_4)

pub const left_pant_leg_enabled = MetadataAccessor(17, get_bit_5, set_bit_5)

pub const right_pant_leg_enabled = MetadataAccessor(17, get_bit_6, set_bit_6)

pub const hat_enabled = MetadataAccessor(17, get_bit_7, set_bit_7)

pub fn get_entity_handedness(metadata: EntityMetadata, index: Int) {
  todo
}

pub fn set_entity_handedness(
  metadata: EntityMetadata,
  index: Int,
  handedness: entity_handedness.EntityHandedness,
) {
  todo
}

pub const main_hand = MetadataAccessor(
  18,
  get_entity_handedness,
  set_entity_handedness,
)

pub fn get_nbt(metadata: EntityMetadata, index: Int) {
  todo
}

pub fn set_nbt(metadata: EntityMetadata, index: Int, nbt: nbeet.Nbt) {
  todo
}

pub const left_shoulder_entity_data = MetadataAccessor(19, get_nbt, set_nbt)

pub const right_shoulder_entity_data = MetadataAccessor(20, get_nbt, set_nbt)

pub fn new(kind: entity_kind.EntityKind) {
  case kind {
    entity_kind.Player -> default_player()
    _ -> []
  }
  |> dict.from_list
  |> EntityMetadata(set.new())
}

fn default_entity() {
  [
    #(0, entity_metadata.Byte(0)),
    #(1, entity_metadata.VarInt(300)),
    #(2, entity_metadata.OptionalTextComponent(option.None)),
    #(3, entity_metadata.Boolean(False)),
    #(4, entity_metadata.Boolean(False)),
    #(5, entity_metadata.Boolean(False)),
    #(6, entity_metadata.Pose(entity_pose.Standing)),
    #(7, entity_metadata.VarInt(0)),
  ]
}

fn default_living_entity() {
  [
    #(8, entity_metadata.Byte(0)),
    #(9, entity_metadata.Float(1.0)),
    #(10, entity_metadata.Particles([])),
    #(11, entity_metadata.Boolean(False)),
    #(12, entity_metadata.VarInt(0)),
    #(13, entity_metadata.VarInt(0)),
    #(14, entity_metadata.OptionalGlobalPosition(option.None)),
    ..default_entity()
  ]
}

fn default_player() {
  [
    #(15, entity_metadata.Float(0.0)),
    #(16, entity_metadata.VarInt(0)),
    #(17, entity_metadata.Byte(0)),
    #(18, entity_metadata.Byte(1)),
    #(19, entity_metadata.NBT(nbeet.empty)),
    #(20, entity_metadata.NBT(nbeet.empty)),
    ..default_living_entity()
  ]
}
