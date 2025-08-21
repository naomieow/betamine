import betamine/common/profile
import betamine/common/uuid
import betamine/constants
import gleam/http/request
import gleam/httpc
import gleam/json
import gleam/result

pub fn fetch_profile(uuid: uuid.Uuid) {
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
