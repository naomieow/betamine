import betamine/common/profile
import betamine/common/uuid
import betamine/constants
import gleam/http/request
import gleam/httpc
import gleam/io
import gleam/json
import gleam/result

pub fn fetch_profile(uuid: uuid.Uuid) {
  // Prepare a HTTP request record
  let assert Ok(req) =
    request.to(
      constants.mojang_base_profile_url
      <> uuid.to_string(uuid)
      <> "?unsigned=false",
    )
  io.debug(req)
  // Send the HTTP request to the server
  use resp <- result.try(httpc.send(req))
  io.debug(resp.body)
  let profile = json.parse(resp.body, profile.decoder())
  io.debug(profile)
  let assert Ok(profile) = profile
  Ok(profile)
}
