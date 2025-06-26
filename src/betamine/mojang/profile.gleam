import betamine/common/profile
import betamine/common/uuid
import betamine/constants
import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}
import gleam/dynamic/decode
import gleam/http/request
import gleam/httpc
import gleam/json
import gleam/option.{type Option}
import gleam/result

pub fn fetch(uuid: uuid.Uuid) {
  let assert Ok(req) =
    request.to(
      constants.mojang_base_profile_url
      <> uuid.to_string(uuid)
      <> "?unsigned=false",
    )
  use resp <- result.try(httpc.send(req))
  let profile = json.parse(resp.body, profile.decoder())
  let assert Ok(profile) = profile
  Ok(profile)
}

pub type ProfileProperty {
  ProfileProperty(name: String, value: String, signature: Option(String))
}

pub fn property_decoder() -> decode.Decoder(ProfileProperty) {
  use name <- decode.field("name", decode.string)
  use value <- decode.field("value", decode.string)
  use signature <- decode.optional_field(
    "signature",
    option.None,
    decode.map(decode.string, option.Some),
  )
  decode.success(ProfileProperty(name:, value:, signature:))
}

pub type Profile {
  Profile(id: uuid.Uuid, name: String, properties: List(ProfileProperty))
}

pub fn default() {
  Profile(uuid.default, "", [])
}

pub fn decoder() {
  use id <- decode.field("id", uuid.decoder())
  use name <- decode.field("name", decode.string)
  use properties <- decode.field("properties", decode.list(property_decoder()))
  decode.success(Profile(id:, name:, properties:))
}

pub fn encode_property(tree: BytesTree, property: ProfileProperty) {
  tree
  |> encoder.string(property.name)
  |> encoder.string(property.value)
  |> encoder.optional(property.signature, encoder.string)
}
