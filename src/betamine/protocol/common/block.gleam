pub type AttachFace {
  AttachFaceFloor
  AttachFaceWall
  AttachFaceCeiling
}

pub type HorizontalFacing {
  HorizontalFacingNorth
  HorizontalFacingSouth
  HorizontalFacingEast
  HorizontalFacingWest
}

pub type Block {
  Air
  Stone
  Grass(snowy: Bool)
  OakButton(face: AttachFace, facing: HorizontalFacing, powered: Bool)
}
