import 'package:flutter/widgets.dart';
import 'package:super_dash/game/super_dash_game.dart';
import 'package:super_dash/procedural/game_state.dart';

void initializeGame() {
  resetProceduralState();
}

void drawMenu() {
  proceduralGameMode.value = ProceduralGameMode.mainMenu;
}

void startGame() {
  resetProceduralRoundState();
}

void pauseGame({SuperDashGame? game}) {
  if (proceduralGameMode.value != ProceduralGameMode.playing) {
    return;
  }
  proceduralGameMode.value = ProceduralGameMode.paused;
  game?.pauseEngine();
  game?.overlays.add('pauseOverlay');
}

void resumeGame({SuperDashGame? game}) {
  if (proceduralGameMode.value != ProceduralGameMode.paused) {
    return;
  }
  proceduralGameMode.value = ProceduralGameMode.playing;
  game?.overlays.remove('pauseOverlay');
  game?.resumeEngine();
}

void restartGame({SuperDashGame? game}) {
  resetProceduralRoundState();
  game?.overlays.remove('pauseOverlay');
  game?.resumeEngine();
}

void showGameOver() {
  proceduralGameMode.value = ProceduralGameMode.gameOver;
}

void exitGame(BuildContext context) {
  drawMenu();
  Navigator.of(context).popUntil((route) => route.isFirst);
}
