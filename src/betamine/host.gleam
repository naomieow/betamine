import betamine/constants
import betamine/game/command
import betamine/session
import gleam/erlang/process.{type Subject}
import gleam/io
import gleam/option.{type Option, None}
import gleam/otp/actor
import glisten.{Packet}

pub fn start(game_subject: Subject(command.Command)) {
  start_with_port(game_subject, constants.default_host_port)
}

pub fn start_with_port(game_subject: Subject(command.Command), port: Int) {
  glisten.new(init(_, game_subject), handler)
  |> glisten.with_close(fn(subject) {
    io.debug("Closing Connection.")
    process.send(subject, session.Disconnect)
  })
  |> glisten.start(port)
}

fn init(
  conn,
  sim_subject: Subject(command.Command),
) -> #(Subject(session.Packet), Option(process.Selector(b))) {
  let subject = process.new_subject()
  let assert Ok(_subject) = session.start(subject, sim_subject, conn)
  let assert Ok(session_subject) = process.receive(subject, 1000)
  #(session_subject, None)
}

fn handler(session_subject: Subject(session.Packet), message, _conn) {
  let assert Packet(data) = message
  process.send(session_subject, session.ServerBoundPacket(data))
  glisten.continue(session_subject)
}
