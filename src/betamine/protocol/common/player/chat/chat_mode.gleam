import betamine/protocol/decoder
import betamine/protocol/error
import gleam/result

pub type ChatMode {
  Enabled
  CommandsOnly
  Hidden
}

pub fn from_int(int: Int) {
  case int {
    0 -> Ok(Enabled)
    1 -> Ok(CommandsOnly)
    2 -> Ok(Hidden)
    _ -> Error(error.InvalidEnumValue("ChatMode", min: 0, max: 2, value: int))
  }
}

pub fn decode(data: BitArray) {
  use #(hand, data) <- result.try(decoder.var_int(data))
  result.map(from_int(hand), fn(hand) { #(hand, data) })
}
