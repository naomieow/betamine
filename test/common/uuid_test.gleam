import betamine/common/uuid
import gleam/dynamic
import gleam/dynamic/decode
import gleeunit/should

const string_uuid = "0c3456dc-85a0-4baf-89b4-db008ec1c749"

const trimmed_string_uuid = "0c3456dc85a04baf89b4db008ec1c749"

const bit_array_uuid = <<
  12, 52, 86, 220, 133, 160, 75, 175, 137, 180, 219, 0, 142, 193, 199, 73,
>>

const int_uuid = 16_222_497_144_839_760_546_306_460_181_120_272_201

fn expected_uuid() {
  uuid.from_string(string_uuid)
  |> should.be_ok
}

pub fn decode_uuid_from_string_test() {
  decode.run(dynamic.string(string_uuid), uuid.decoder())
  |> should.be_ok
  |> should.equal(expected_uuid())
}

pub fn decode_uuid_from_trimmed_string_test() {
  decode.run(dynamic.string(trimmed_string_uuid), uuid.decoder())
  |> should.be_ok
  |> should.equal(expected_uuid())
}

pub fn decode_uuid_from_bit_array_test() {
  decode.run(dynamic.bit_array(bit_array_uuid), uuid.decoder())
  |> should.be_ok
  |> should.equal(expected_uuid())
}

pub fn decode_uuid_from_int_test() {
  decode.run(dynamic.int(int_uuid), uuid.decoder())
  |> should.be_ok
  |> should.equal(expected_uuid())
}
