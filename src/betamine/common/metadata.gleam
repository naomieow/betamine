import betamine/common/vector3
import gleam/option

pub type Pose {
  Standing
  FallFlying
  Sleeping
  Swimming
  SpinAttack
  Sneaking
  LongJumping
  Dying
  Croaking
  UsingTongue
  Sitting
  Roaring
  Sniffing
  Emerging
  Digging
}

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
    custom_name: String,
    is_custom_name_visible: Bool,
    is_silent: Bool,
    is_weightless: Bool,
    pose: Pose,
    powdered_snow_ticks: Int,
  )
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

pub type PlayerMetadata {
  PlayerMetadata(is_sneaking: Bool)
}

pub const default_player_metadata = PlayerMetadata(False)
