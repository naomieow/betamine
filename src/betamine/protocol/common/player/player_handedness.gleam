import betamine/protocol/decoder
import betamine/protocol/error
import gleam/result

pub type Handedness {
  Right
  Left
}

pub fn to_int(handedness: Handedness) {
  case handedness {
    Left -> 0
    Right -> 1
  }
}

pub fn from_int(int: Int) {
  case int {
    0 -> Ok(Left)
    1 -> Ok(Right)
    _ -> Error(error.InvalidEnumValue("Handedness", min: 0, max: 1, value: int))
  }
}

pub fn decode(data: BitArray) {
  use #(int, data) <- result.try(decoder.var_int(data))
  use handedness <- result.try(from_int(int))
  Ok(#(handedness, data))
}
