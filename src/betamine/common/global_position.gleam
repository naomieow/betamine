import betamine/common/identifier.{type Identifier}
import betamine/common/position.{type Position}

pub type GlobalPosition {
  GlobalPosition(identifier: Identifier, position: Position)
}
