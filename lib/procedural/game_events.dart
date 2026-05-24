import 'package:flutter/widgets.dart';
import 'package:super_dash/game/super_dash_game.dart';
import 'package:super_dash/procedural/game_flow.dart';
import 'package:super_dash/procedural/game_logic.dart';

enum MenuAction {
  startGame,
  pauseGame,
  resumeGame,
  restartGame,
  exitGame,
}

void onKeyboardInputEvent({required SuperDashGame game}) {
  handleInput(game: game);
}

void onPointerInputEvent({required SuperDashGame game}) {
  handleInput(game: game);
}

void onMenuSelectionEvent({
  required MenuAction action,
  required BuildContext context,
  SuperDashGame? game,
}) {
  switch (action) {
    case MenuAction.startGame:
      startGame();
    case MenuAction.pauseGame:
      pauseGame(game: game);
    case MenuAction.resumeGame:
      resumeGame(game: game);
    case MenuAction.restartGame:
      restartGame(game: game);
    case MenuAction.exitGame:
      exitGame(context);
  }
}

void onTimerTickEvent({
  required SuperDashGame game,
  required double deltaSeconds,
}) {
  updateGame(
    game: game,
    deltaSeconds: deltaSeconds,
  );
}

void onCollisionTriggeredEvent({
  required SuperDashGame game,
  required String collisionType,
}) {
  detectCollision(
    game: game,
    collisionType: collisionType,
  );
}
