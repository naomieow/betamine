import betamine/common/position.{type Position}
import betamine/common/vector3.{Vector3}
import gleam/dynamic
import gleam/dynamic/decode
import gleeunit/should

const position: Position = Vector3(18_357_644, -20_882_616, 831)

pub fn to_int_test() {
  position.to_int(position)
  |> should.equal(5_046_110_948_485_792_575)
}

pub fn to_bit_array() {
  position.to_int(position)
  |> should.equal(<<
    0b01000110000001110110001100,
    0b10110000010101101101001000,
    0b001100111111,
  >>)
}
