import betamine/protocol/common/entity/metadata/metadata_data_type
import gleam/list

pub type EntityMetadata =
  List(#(Int, metadata_data_type.MetadataDataType))

pub fn encode(metadata: EntityMetadata) {
  todo
}

fn encode_data_type() {
  todo
}
