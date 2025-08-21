import betamine/common/identifier.{type Identifier}
import betamine/common/vector3.{type Vector3}

pub type Position =
  Vector3(Int)

pub fn to_bit_array(position: Position) {
  <<position.x:int-size(26), position.z:int-size(26), position.y:int-size(26)>>
}

pub fn to_int(position: Position) {
  todo
}
