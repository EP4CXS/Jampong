import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_dash/audio/audio.dart';
import 'package:super_dash/game/game.dart';
import 'package:super_dash/game_intro/game_intro.dart';
import 'package:super_dash/procedural/procedural.dart';
import 'package:super_dash/services/voice_control_service.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  static PageRoute<void> route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const Game(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: const GameView(),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  SuperDashGame? _game;
  late final VoiceControlService _voiceControlService;
  bool _voiceEnabled = false;

  @override
  void initState() {
    super.initState();
    _voiceControlService = VoiceControlService(onJumpCommand: _onJumpCommand);
    initializeGame();
    startGame();
  }

  @override
  void dispose() {
    _voiceControlService.dispose();
    super.dispose();
  }

  void _onJumpCommand() {
    final game = _game;
    if (game == null) return;
    game.triggerPrimaryInput();
  }

  Future<void> _toggleVoiceControl() async {
    setState(() {
      _voiceEnabled = !_voiceEnabled;
    });

    if (_voiceEnabled) {
      await _voiceControlService.startListening();
    } else {
      await _voiceControlService.stopListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        updateScore(score: state.score);
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            GameWidget.controlled(
              loadingBuilder: (context) => const GameBackground(),
              backgroundBuilder: (context) => const GameBackground(),
              gameFactory: () {
                final game = SuperDashGame(
                  gameBloc: context.read<GameBloc>(),
                  audioController: context.read<AudioController>(),
                );
                _game = game;
                return game;
              },
              overlayBuilderMap: {
                'tapToJump': (context, game) => const TapToJumpOverlay(),
                'pauseOverlay': (context, game) {
                  if (game is! SuperDashGame) {
                    return const SizedBox.shrink();
                  }
                  return PauseOverlay(
                    onResume: () => onMenuSelectionEvent(
                      action: MenuAction.resumeGame,
                      context: context,
                      game: game,
                    ),
                    onRestart: () => onMenuSelectionEvent(
                      action: MenuAction.restartGame,
                      context: context,
                      game: game,
                    ),
                    onExit: () => onMenuSelectionEvent(
                      action: MenuAction.exitGame,
                      context: context,
                      game: game,
                    ),
                  );
                },
              },
              initialActiveOverlays: const ['tapToJump'],
            ),
            const Positioned(
              top: 12,
              child: ScoreLabel(),
            ),
            const Positioned(
              top: 76,
              child: TimerLabel(),
            ),
            const Positioned(
              top: 128,
              child: LivesLabel(),
            ),
            Positioned(
              top: 12,
              right: 16,
              child: SafeArea(
                child: IconButton.filledTonal(
                  onPressed: () {
                    final game = _game;
                    if (game == null) {
                      return;
                    }
                    if (proceduralGameMode.value == ProceduralGameMode.paused) {
                      onMenuSelectionEvent(
                        action: MenuAction.resumeGame,
                        context: context,
                        game: game,
                      );
                    } else {
                      onMenuSelectionEvent(
                        action: MenuAction.pauseGame,
                        context: context,
                        game: game,
                      );
                    }
                  },
                  icon: ValueListenableBuilder<ProceduralGameMode>(
                    valueListenable: proceduralGameMode,
                    builder: (context, mode, _) {
                      return Icon(
                        mode == ProceduralGameMode.paused
                            ? Icons.play_arrow
                            : Icons.pause,
                      );
                    },
                  ),
                ),
              ),
            ),
            // Voice control toggle and status
            Positioned(
              top: 50,
              right: 16,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      onPressed: _toggleVoiceControl,
                      icon: Icon(
                        _voiceEnabled ? Icons.mic : Icons.mic_off,
                        color: _voiceEnabled ? Colors.green : Colors.grey,
                      ),
                    ),
                    if (_voiceControlService.isAvailable)
                      Text(
                        _voiceControlService.isListening
                            ? 'Listening...'
                            : _voiceEnabled
                                ? 'Voice: ON'
                                : 'Voice: OFF',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      )
                    else
                      const Text(
                        'Voice: Not Available',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 12,
              child: SafeArea(child: AudioButton()),
            ),
            Positioned(
              bottom: 80,
              child: ValueListenableBuilder<ProceduralGameMode>(
                valueListenable: proceduralGameMode,
                builder: (context, mode, _) {
                  if (mode != ProceduralGameMode.gameOver) {
                    return const SizedBox.shrink();
                  }
                  return const Chip(
                    label: Text('Game Over'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
