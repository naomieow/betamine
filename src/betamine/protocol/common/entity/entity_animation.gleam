import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}

pub type EntityAnimation {
  SwingDominantArm
  LeaveBed
  SwingNonDominantArm
  CriticalEffect
  MagicalCriticalEffect
}

pub fn to_int(animation: EntityAnimation) {
  case animation {
    SwingDominantArm -> 0
    LeaveBed -> 2
    SwingNonDominantArm -> 3
    CriticalEffect -> 4
    MagicalCriticalEffect -> 5
  }
}

pub fn encode(tree: BytesTree, animation: EntityAnimation) {
  encoder.byte(tree, to_int(animation))
}
