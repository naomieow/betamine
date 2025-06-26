pub type PlayerGameMode {
  Survival
  Creative
  Adventure
  Spectator
}

pub fn to_int(game_mode: PlayerGameMode) {
  case game_mode {
    Survival -> 0
    Creative -> 1
    Adventure -> 2
    Spectator -> 3
  }
}
