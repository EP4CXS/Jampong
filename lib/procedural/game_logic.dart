import 'package:super_dash/game/super_dash_game.dart';
import 'package:super_dash/procedural/game_flow.dart';
import 'package:super_dash/procedural/game_state.dart';

void handleInput({
  required SuperDashGame game,
  bool triggerJump = true,
}) {
  if (proceduralGameMode.value == ProceduralGameMode.paused) {
    return;
  }
  if (triggerJump) {
    game.triggerPrimaryInput();
  }
}

void updateGame({
  required SuperDashGame game,
  required double deltaSeconds,
}) {
  switch (proceduralGameMode.value) {
    case ProceduralGameMode.mainMenu:
      drawMenu();
    case ProceduralGameMode.playing:
      consumeElapsedTime(deltaSeconds);
      movePlayer(game: game);
      spawnEnemies(game: game);
      detectCollision(game: game);
      if (proceduralTimerSeconds.value <= 0) {
        showGameOver();
      }
    case ProceduralGameMode.paused:
      displayTimer();
    case ProceduralGameMode.gameOver:
      displayTimer();
    case ProceduralGameMode.victory:
      displayTimer();
  }
}

void movePlayer({required SuperDashGame game}) {
  final player = game.player;
  if (player == null) {
    return;
  }
  if (proceduralGameMode.value != ProceduralGameMode.playing) {
    player.walking = false;
  }
}

void spawnEnemies({required SuperDashGame game}) {
  // Spawning remains managed by the existing proximity builders.
  // This hook exists to keep spawn logic event-driven/procedural.
}

void detectCollision({
  required SuperDashGame game,
  String? collisionType,
}) {
  if (collisionType == 'enemy-hit') {
    proceduralLives.value =
        proceduralLives.value > 0 ? proceduralLives.value - 1 : 0;
    if (proceduralLives.value <= 0) {
      showGameOver();
    }
  }
  if (collisionType == 'goal') {
    proceduralGameMode.value = ProceduralGameMode.victory;
  }
  if (collisionType == 'game-over') {
    showGameOver();
  }
}

void updateScore({required int score}) {
  proceduralScore.value = score;
}

int displayTimer() {
  return proceduralTimerSeconds.value;
}
