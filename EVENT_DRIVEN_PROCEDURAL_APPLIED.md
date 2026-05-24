# Event-Driven + Procedural Applied Guide

This document describes how Event-Driven Programming and Procedural Programming are applied in the `super_dash` project while keeping Flutter/Flame as required framework shell.

## 1) Core Principle Used

- Flutter/Flame classes are kept as runtime shell (required by framework).
- Game orchestration is moved into procedural modules and function-based handlers.
- Input, timer, menu, and collision pathways are event-driven.
- Game states are controlled via a procedural state machine.

## 2) Procedural Module Layout

The procedural layer lives in:

- `lib/procedural/game_state.dart`
- `lib/procedural/game_events.dart`
- `lib/procedural/game_flow.dart`
- `lib/procedural/game_logic.dart`
- `lib/procedural/procedural.dart`

### Purpose of each file

- `game_state.dart`
  - Holds procedural mode enum and shared state variables.
  - Stores score, timer, lives, and reset helpers.
- `game_events.dart`
  - Event entry points for keyboard, pointer/tap, menu, timer tick, and collision.
- `game_flow.dart`
  - Lifecycle/flow functions: initialize, start, pause/resume, restart, game over, exit.
- `game_logic.dart`
  - Tick logic and procedural handlers for input, movement hooks, collision, score, timer.

## 3) Required Procedural Functions Implemented

The required functions are present and mapped as follows:

- `initializeGame()` -> `lib/procedural/game_flow.dart`
- `drawMenu()` -> `lib/procedural/game_flow.dart`
- `startGame()` -> `lib/procedural/game_flow.dart`
- `pauseGame()` -> `lib/procedural/game_flow.dart`
- `resumeGame()` -> `lib/procedural/game_flow.dart`
- `restartGame()` -> `lib/procedural/game_flow.dart`
- `handleInput()` -> `lib/procedural/game_logic.dart`
- `updateGame()` -> `lib/procedural/game_logic.dart`
- `movePlayer()` -> `lib/procedural/game_logic.dart`
- `spawnEnemies()` -> `lib/procedural/game_logic.dart`
- `detectCollision()` -> `lib/procedural/game_logic.dart`
- `updateScore()` -> `lib/procedural/game_logic.dart`
- `displayTimer()` -> `lib/procedural/game_logic.dart`
- `showGameOver()` -> `lib/procedural/game_flow.dart`
- `exitGame()` -> `lib/procedural/game_flow.dart`

## 4) Event-Driven Wiring in Existing Game

### Input events

- Keyboard and pointer/tap are routed through event handlers in:
  - `lib/game/super_dash_game.dart`
  - `lib/procedural/game_events.dart`

`SuperDashGame` now uses procedural event adapters:

- `onKeyboardInputEvent(...)`
- `onPointerInputEvent(...)`

### Timer/tick events

- Per-frame update in `SuperDashGame.update(double dt)` calls:
  - `onTimerTickEvent(game: this, deltaSeconds: dt)`

That dispatches to `updateGame(...)` in the procedural logic.

### Collision-triggered events

- Player collision branches in `lib/game/entities/player.dart` forward to:
  - `onCollisionTriggeredEvent(...)`

This keeps collision reactions event-driven while preserving existing physics behavior.

### Menu/button events

- UI buttons call procedural menu actions via:
  - `onMenuSelectionEvent(...)`

Used in:

- `lib/game_intro/view/game_intro_page.dart`
- `lib/score/score_overview/widgets/buttons.dart`
- `lib/game/view/game_view.dart` (pause overlay and controls)

## 5) Procedural State Machine

Defined in `lib/procedural/game_state.dart`:

- `MainMenu`
- `Playing`
- `Paused`
- `GameOver`
- `Victory`

State transitions are driven using procedural flow functions and event handlers, primarily with `switch` logic in `updateGame(...)`.

## 6) HUD and Overlay Integration

Additional UI pieces connected to procedural state:

- `lib/game/widgets/timer_label.dart`
- `lib/game/widgets/lives_label.dart`
- `lib/game/widgets/pause_overlay.dart`

Exports are centralized in:

- `lib/game/widgets/widgets.dart`

These display procedural timer/lives and provide pause/resume/restart/exit event actions.

## 7) Framework Compatibility Notes

- Flame/Leap internals remain intact (movement, spawning, map handling, entity updates).
- Procedural logic orchestrates behavior around those internals rather than replacing them.
- Existing navigation and score flow remain in place, with procedural hooks added.

## 8) Quick Trace (Input -> Action)

1. User presses keyboard/taps.
2. `SuperDashGame` routes to procedural event handler.
3. `handleInput(...)` runs procedural logic.
4. Shared procedural state updates.
5. UI overlays/HUD react via `ValueNotifier` listeners.

## 9) What this gives you

- Clear procedural function boundaries.
- Event-driven behavior for input/timer/menu/collision.
- Minimal architecture risk because core engine logic is preserved.
- Easier testing and extension of gameplay flow in function-based modules.
