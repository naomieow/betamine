import betamine/common/entity
import betamine/common/entity/entity_kind

pub type Pig {
  Pig(entity: entity.Entity)
}

pub fn new() {
  Pig(entity: entity.new(entity_kind.Pig))
}
