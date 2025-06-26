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
