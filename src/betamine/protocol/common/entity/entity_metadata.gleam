import betamine/common/vector3
import betamine/protocol/common/entity/entity_pose
import betamine/protocol/common/player/player_handedness
import betamine/protocol/common/player/player_model_customization
import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}
import gleam/option
import nbeet

pub type EntityMetadata {
  EntityMetadata(
    is_on_fire: Bool,
    is_sneaking: Bool,
    is_sprinting: Bool,
    is_swimming: Bool,
    is_invisible: Bool,
    is_glowing: Bool,
    is_flying: Bool,
    air_ticks: Int,
    custom_name: option.Option(String),
    is_custom_name_visible: Bool,
    is_silent: Bool,
    is_weightless: Bool,
    pose: entity_pose.EntityPose,
    powdered_snow_ticks: Int,
  )
}

pub fn default_entity_metadata() {
  EntityMetadata(
    False,
    False,
    False,
    False,
    False,
    False,
    False,
    300,
    option.None,
    False,
    False,
    False,
    entity_pose.Standing,
    0,
  )
}

pub fn encode_entity_metadata(tree: BytesTree, metadata: EntityMetadata) {
  tree
  |> encoder.bitmask([
    metadata.is_on_fire,
    metadata.is_sneaking,
    metadata.is_sprinting,
    metadata.is_swimming,
    metadata.is_invisible,
    metadata.is_glowing,
    metadata.is_flying,
  ])
  |> encoder.var_int(metadata.air_ticks)
  |> encoder.optional(metadata.custom_name, encoder.string)
}

pub type LivingEntityMetadata {
  LivingEntityMetadata(
    entity_metadata: EntityMetadata,
    is_hand_active: Bool,
    is_offhand_active: Bool,
    is_spin_attacking: Bool,
    health: Float,
    potion_effect_color: List(Nil),
    is_ambient_potion_effect: Bool,
    arrows_in_entity: Int,
    bee_stingers_in_entity: Int,
    sleeping_bed_location: option.Option(vector3.Vector3(Float)),
  )
}

pub fn default_living_entity_metadata() {
  LivingEntityMetadata(
    default_entity_metadata(),
    False,
    False,
    False,
    1.0,
    [],
    False,
    0,
    0,
    option.None,
  )
}

pub type PlayerMetadata {
  PlayerMetadata(
    living_entity_metadata: LivingEntityMetadata,
    additional_hearts: Float,
    score: Int,
    model_customization: player_model_customization.PlayerModelCustomization,
    main_hand: player_handedness.Handedness,
    left_shoulder_entity_data: nbeet.Nbt,
    right_shoulder_entity_data: nbeet.Nbt,
  )
}

pub type PlayerMetadataValue {
  AdditionalHearts(Float)
  Score(Int)
  ModelCustomization(player_model_customization.PlayerModelCustomization)
  MainHand(player_handedness.Handedness)
  LeftShoulderEntityData(nbeet.Nbt)
  RightShoulderEntityData(nbeet.Nbt)
}

pub fn default_player_metadata() {
  PlayerMetadata(
    default_living_entity_metadata(),
    0.0,
    0,
    player_model_customization.default,
    player_handedness.Right,
    nbeet.root([]),
    nbeet.root([]),
  )
}
