pub type PlayerModelCustomization {
  PlayerModelCustomization(
    is_cape_enabled: Bool,
    is_jacket_enabled: Bool,
    is_left_sleeve_enabled: Bool,
    is_right_sleeve_enabled: Bool,
    is_left_pant_enabled: Bool,
    is_right_pant_enabled: Bool,
    is_hat_enabled: Bool,
  )
}

pub const default = PlayerModelCustomization(
  False,
  False,
  False,
  False,
  False,
  False,
  False,
)
