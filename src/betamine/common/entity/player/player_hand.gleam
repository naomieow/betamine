import betamine/protocol/decoder
import betamine/protocol/error
import gleam/result

pub type PlayerHand {
  Dominant
  NonDominant
}

pub const default = Dominant

pub fn from_int(int: Int) {
  case int {
    0 -> Ok(Dominant)
    1 -> Ok(NonDominant)
    int -> Error(error.InvalidEnumValue("Hand", 0, 1, int))
  }
}

pub fn decode(data: BitArray) {
  use #(hand, data) <- result.try(decoder.var_int(data))
  result.map(from_int(hand), fn(hand) { #(hand, data) })
}
