import betamine/protocol/decoder
import betamine/protocol/error
import gleam/result

pub type PlayerCommandAction {
  StartSneaking
  StopSneaking
  LeaveBed
  StartSprinting
  StopSprinting
  StartHorseJump
  StopHorseJump
  OpenVehicleInventory
  StartElytraFlying
}

pub fn decode(data: BitArray) {
  use #(action, data) <- result.try(decoder.var_int(data))
  let action = case action {
    0 -> Ok(StartSneaking)
    1 -> Ok(StopSneaking)
    2 -> Ok(LeaveBed)
    3 -> Ok(StartSprinting)
    4 -> Ok(StopSprinting)
    5 -> Ok(StartHorseJump)
    6 -> Ok(StopHorseJump)
    7 -> Ok(OpenVehicleInventory)
    8 -> Ok(StartElytraFlying)
    value -> Error(error.InvalidEnumValue("PlayerCommandAction", 0, 8, value))
  }
  result.map(action, fn(action) { #(action, data) })
}
