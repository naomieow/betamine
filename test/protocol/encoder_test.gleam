import betamine/protocol/encoder
import gleam/bytes_tree
import gleeunit/should

fn encode_var_int(int: Int) {
  encoder.var_int(bytes_tree.new(), int)
  |> bytes_tree.to_bit_array
}

pub fn encode_var_int_min_test() {
  encode_var_int(-2_147_483_648)
  |> should.equal(<<0x80, 0x80, 0x80, 0x80, 0x08>>)
}

pub fn encode_var_int_max_test() {
  encode_var_int(2_147_483_647)
  |> should.equal(<<0xFF, 0xFF, 0xFF, 0xFF, 0x07>>)
}

pub fn encode_var_int_zero_test() {
  encode_var_int(0)
  |> should.equal(<<0x00>>)
}

pub fn encode_var_int_one_test() {
  encode_var_int(1)
  |> should.equal(<<0x01>>)
}

pub fn encode_var_int_negative_one_test() {
  encode_var_int(-1)
  |> should.equal(<<0xFF, 0xFF, 0xFF, 0xFF, 0x0F>>)
}

pub fn encode_var_int_test() {
  encode_var_int(200)
  |> should.equal(<<200, 1>>)
}

fn encode_bitmask(bitmask: List(Bool)) {
  encoder.bitmask(bytes_tree.new(), bitmask)
  |> bytes_tree.to_bit_array
}

pub fn encode_bitmask_empty_test() {
  encode_bitmask([])
  |> should.equal(<<0>>)
}

pub fn encode_bitmask_min_test() {
  encode_bitmask([True])
  |> should.equal(<<0b00000001>>)
}

pub fn encode_bitmask_mixed_test() {
  encode_bitmask([False, True, False, True, False, True, False, True])
  |> should.equal(<<0b10101010>>)
}

pub fn encode_bitmask_full_test() {
  encode_bitmask([True, True, True, True, True, True, True, True])
  |> should.equal(<<0b11111111>>)
}

pub fn encode_bitmask_zero_test() {
  encode_bitmask([False, False, False, False, False, False, False, False])
  |> should.equal(<<0>>)
}

pub fn encode_bitmask_overflow_test() {
  encode_bitmask([False, True, True, True, True, True, True, True, True])
  |> should.equal(<<0b11111110>>)
}
