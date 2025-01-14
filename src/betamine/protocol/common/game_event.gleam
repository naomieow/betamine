import betamine/common/game_mode.{type GameMode}
import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}
import gleam/int

pub type GameEvent {
  NoRespawnBlockAvailable
  StartRain
  EndRain
  ChangeGameMode(GameMode)
  WinGame(play_credits: Bool)
  DemoEvent(DemoEvent)
  ArrowHitPlayer
  RainLevelChange(Float)
  ThunderLevelChange(Float)
  PlayPufferfishStingSound
  PlayElderGaurdianEffect
  EnableRespawnScreen(Bool)
  LimitedCrafting(Bool)
  WaitForChunks
}

pub type DemoEvent {
  ShowDemoScreen
  TellMovementControls
  TellJumpControls
  TellInventoryControls
  TellDemoComplete
}

pub fn encode(tree: BytesTree, game_event: GameEvent) {
  case game_event {
    NoRespawnBlockAvailable -> {
      tree
      |> encoder.byte(0)
      |> encoder.float(0.0)
    }
    StartRain -> {
      tree
      |> encoder.byte(1)
      |> encoder.float(0.0)
    }
    EndRain -> {
      tree
      |> encoder.byte(2)
      |> encoder.float(0.0)
    }
    ChangeGameMode(game_mode) -> {
      tree
      |> encoder.byte(3)
      |> encoder.float(game_mode |> game_mode.to_int |> int.to_float)
    }
    WinGame(play_credits) -> {
      tree
      |> encoder.byte(4)
      |> encoder.float(case play_credits {
        False -> 0.0
        True -> 1.0
      })
    }
    DemoEvent(demo_event) -> {
      tree
      |> encoder.byte(5)
      |> encoder.float(case demo_event {
        ShowDemoScreen -> 0.0
        TellMovementControls -> 101.0
        TellJumpControls -> 102.0
        TellInventoryControls -> 103.0
        TellDemoComplete -> 104.0
      })
    }
    ArrowHitPlayer -> {
      tree
      |> encoder.byte(6)
      |> encoder.float(0.0)
    }
    RainLevelChange(level) -> {
      tree
      |> encoder.byte(7)
      |> encoder.float(level)
    }
    ThunderLevelChange(level) -> {
      tree
      |> encoder.byte(8)
      |> encoder.float(level)
    }
    PlayPufferfishStingSound -> {
      tree
      |> encoder.byte(9)
      |> encoder.float(0.0)
    }
    PlayElderGaurdianEffect -> {
      tree
      |> encoder.byte(10)
      |> encoder.float(0.0)
    }
    EnableRespawnScreen(enabled) -> {
      tree
      |> encoder.byte(11)
      |> encoder.float(case enabled {
        False -> 0.0
        True -> 1.0
      })
    }
    LimitedCrafting(enabled) -> {
      tree
      |> encoder.byte(12)
      |> encoder.float(case enabled {
        False -> 0.0
        True -> 1.0
      })
    }
    WaitForChunks -> {
      tree
      |> encoder.byte(13)
      |> encoder.float(0.0)
    }
  }
}
