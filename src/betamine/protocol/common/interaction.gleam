import betamine/common/vector3.{type Vector3, Vector3}
import betamine/protocol/decoder
import betamine/protocol/error
import gleam/result

pub type Interaction {
  Interact(off_hand: Bool)
  Attack
  InteractAt(target: Vector3(Float), off_hand: Bool)
}

pub fn decode(data: BitArray) {
  use #(interaction_type, data) <- result.try(decoder.var_int(data))
  case interaction_type {
    0 -> {
      use #(off_hand, data) <- result.try(decoder.boolean(data))
      Ok(#(Interact(off_hand), data))
    }
    1 -> Ok(#(Attack, data))
    2 -> {
      use #(x, data) <- result.try(decoder.float(data))
      use #(y, data) <- result.try(decoder.float(data))
      use #(z, data) <- result.try(decoder.float(data))
      use #(off_hand, data) <- result.try(decoder.boolean(data))
      Ok(#(InteractAt(Vector3(x, y, z), off_hand), data))
    }
    value -> Error(error.InvalidEnumValue("Interaction", 0, 2, value))
  }
}
