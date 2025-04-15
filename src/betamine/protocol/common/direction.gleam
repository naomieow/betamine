pub type Direction {
  Down
  Up
  North
  South
  West
  East
}

pub fn to_int(direction: Direction) {
  case direction {
    Down -> 0
    Up -> 1
    North -> 2
    South -> 3
    West -> 4
    East -> 5
  }
}
