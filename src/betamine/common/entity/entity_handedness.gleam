import betamine/protocol/decoder
import betamine/protocol/error
import gleam/pair
import gleam/result

pub type EntityHandedness {
  Right
  Left
}

pub fn to_int(handedness: EntityHandedness) {
  case handedness {
    Left -> 0
    Right -> 1
  }
}

pub fn from_int(int: Int) {
  case int {
    0 -> Ok(Left)
    1 -> Ok(Right)
    _ ->
      Error(error.InvalidEnumValue(
        "EntityHandedness",
        min: 0,
        max: 1,
        value: int,
      ))
  }
}

pub fn decode(data: BitArray) {
  use #(handedness, data) <- result.try(decoder.var_int(data))
  result.map(from_int(handedness), pair.new(_, data))
}
