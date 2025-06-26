import gleam/list

pub type Quaternion(a) {
  Quaternion(x: a, y: a, z: a, w: a)
}

pub fn equal(first: Quaternion(a), second: Quaternion(a)) {
  first.x == second.x
  && first.y == second.y
  && first.z == second.z
  && first.w == second.w
}

pub fn to_list(quaternion: Quaternion(a)) {
  [quaternion.x, quaternion.y, quaternion.z, quaternion.w]
}

pub fn fold(
  over quaternion: Quaternion(a),
  from initial: b,
  with fun: fn(b, a) -> b,
) -> b {
  to_list(quaternion)
  |> list.fold(initial, fun)
}
