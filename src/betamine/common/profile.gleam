import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}
import gleam/option.{type Option}

pub type Profile {
  Profile(id: Int, name: String, properties: List(ProfileProperty))
}

pub type ProfileProperty {
  ProfileProperty(name: String, value: String, signature: Option(String))
}

pub fn encode_profile_property(tree: BytesTree, property: ProfileProperty) {
  tree
  |> encoder.string(property.name)
  |> encoder.string(property.value)
  |> encoder.optional(property.signature, encoder.string)
}
