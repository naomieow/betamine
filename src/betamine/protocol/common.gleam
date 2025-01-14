import betamine/common/vector3.{type Vector3}
import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}
import gleam/float

pub fn encode_velocity(tree: BytesTree, velocity: Vector3(Float)) {
  velocity
  |> vector3.map(fn(value) { float.clamp(value, -3.9, 3.9) *. 8000.0 })
  |> vector3.truncate
  |> vector3.fold(tree, encoder.short)
}

pub fn encode_delta(tree, delta: Vector3(Float)) {
  delta
  |> vector3.map(fn(value) { value *. 4096.0 })
  |> vector3.truncate
  |> vector3.fold(tree, encoder.short)
}
