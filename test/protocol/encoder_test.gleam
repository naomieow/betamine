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
