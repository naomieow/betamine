pub type EntityPose {
  Standing
  FallFlying
  Sleeping
  Swimming
  SpinAttack
  Crouching
  LongJumping
  Dying
  Croaking
  UsingTongue
  Sitting
  Roaring
  Sniffing
  Emerging
  Digging
  Sliding
  Shooting
  Inhaling
}

pub fn to_int(pose: EntityPose) {
  case pose {
    Standing -> 0
    FallFlying -> 1
    Sleeping -> 2
    Swimming -> 3
    SpinAttack -> 4
    Crouching -> 5
    LongJumping -> 6
    Dying -> 7
    Croaking -> 8
    UsingTongue -> 9
    Sitting -> 10
    Roaring -> 11
    Sniffing -> 12
    Emerging -> 13
    Digging -> 14
    Sliding -> 15
    Shooting -> 16
    Inhaling -> 17
  }
}
