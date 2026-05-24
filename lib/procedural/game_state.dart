import 'package:flutter/widgets.dart';

enum ProceduralGameMode {
  mainMenu,
  playing,
  paused,
  gameOver,
  victory,
}

const int initialLives = 1;
const int initialTimerSeconds = 180;

final ValueNotifier<ProceduralGameMode> proceduralGameMode =
    ValueNotifier(ProceduralGameMode.mainMenu);
final ValueNotifier<int> proceduralScore = ValueNotifier(0);
final ValueNotifier<int> proceduralTimerSeconds =
    ValueNotifier(initialTimerSeconds);
final ValueNotifier<int> proceduralLives = ValueNotifier(initialLives);

double _timerAccumulatorSeconds = 0;

void resetProceduralState() {
  proceduralGameMode.value = ProceduralGameMode.mainMenu;
  proceduralScore.value = 0;
  proceduralTimerSeconds.value = initialTimerSeconds;
  proceduralLives.value = initialLives;
  _timerAccumulatorSeconds = 0;
}

void resetProceduralRoundState() {
  proceduralGameMode.value = ProceduralGameMode.playing;
  proceduralTimerSeconds.value = initialTimerSeconds;
  proceduralLives.value = initialLives;
  _timerAccumulatorSeconds = 0;
}

void consumeElapsedTime(double deltaSeconds) {
  _timerAccumulatorSeconds += deltaSeconds;
  while (_timerAccumulatorSeconds >= 1) {
    _timerAccumulatorSeconds -= 1;
    if (proceduralGameMode.value == ProceduralGameMode.playing &&
        proceduralTimerSeconds.value > 0) {
      proceduralTimerSeconds.value--;
    }
  }
}
