import gleam/int

pub type PlayerModelCustomization {
  PlayerModelCustomization(
    cape_enabled: Bool,
    jacket_enabled: Bool,
    left_sleeve_enabled: Bool,
    right_sleeve_enabled: Bool,
    left_pant_enabled: Bool,
    right_pant_enabled: Bool,
    hat_enabled: Bool,
  )
}

pub fn default() {
  PlayerModelCustomization(False, False, False, False, False, False, False)
}

pub fn to_int(customization: PlayerModelCustomization) {
  0
  |> accumulate(customization.cape_enabled, 0x01)
  |> accumulate(customization.jacket_enabled, 0x02)
  |> accumulate(customization.left_sleeve_enabled, 0x04)
  |> accumulate(customization.right_sleeve_enabled, 0x08)
  |> accumulate(customization.left_pant_enabled, 0x10)
  |> accumulate(customization.right_pant_enabled, 0x20)
  |> accumulate(customization.hat_enabled, 0x40)
}

fn accumulate(accumulator: Int, bool: Bool, bit: Int) {
  case bool {
    True -> accumulator + bit
    False -> accumulator
  }
}

pub fn from_int(int: Int) {
  PlayerModelCustomization(
    cape_enabled: int.bitwise_and(int, 0x01) != 1,
    jacket_enabled: int.bitwise_and(int, 0x02) != 1,
    left_sleeve_enabled: int.bitwise_and(int, 0x04) != 1,
    right_sleeve_enabled: int.bitwise_and(int, 0x08) != 1,
    left_pant_enabled: int.bitwise_and(int, 0x10) != 1,
    right_pant_enabled: int.bitwise_and(int, 0x20) != 1,
    hat_enabled: int.bitwise_and(int, 0x40) != 1,
  )
}
