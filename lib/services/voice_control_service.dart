import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_recognition_result.dart' as srr;
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceControlService {
  VoiceControlService({required this.onJumpCommand});

  final VoidCallback onJumpCommand;
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isInitialized = false;
  String _lastTranscript = '';
  int _processedJumpTokenCount = 0;
  static const int _maxJumpsPerResult = 5;
  static final RegExp _jumpTokenPattern =
      RegExp(r'\b(jump|fly|up|go)\b', caseSensitive: false);

  Future<bool> initialize() async {
    if (_isInitialized) return true;
    return _isInitialized = await _speech.initialize(
      onStatus: (val) => debugPrint('onStatus: $val'),
      onError: (val) => debugPrint('onError: $val'),
    );
  }

  Future<void> startListening() async {
    if (!_isInitialized) {
      final success = await initialize();
      if (!success) {
        debugPrint('Failed to initialize speech to text');
        return;
      }
    }

    if (_isListening) return;

    _resetTrackingState(reason: 'start-listening');
    _isListening = true;
    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: 'en_US',
      listenOptions: stt.SpeechListenOptions(
        cancelOnError: true,
      ),
    );
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    _isListening = false;
    await _speech.stop();
    _resetTrackingState(reason: 'stop-listening');
  }

  void _onSpeechResult(srr.SpeechRecognitionResult result) {
    final normalizedText = result.recognizedWords
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    // #region agent log
    debugPrint(
      'Speech recognized: "$normalizedText" '
      '(finalResult: ${result.finalResult})',
    );
    // #endregion

    if (normalizedText.isEmpty) {
      _resetTrackingState(reason: 'empty-transcript');
      return;
    }

    final hasPhraseProgression = normalizedText.startsWith(_lastTranscript);
    if (_lastTranscript.isNotEmpty && !hasPhraseProgression) {
      _resetTrackingState(reason: 'transcript-restarted');
    }

    final totalJumpTokenCount =
        _jumpTokenPattern.allMatches(normalizedText).length;
    final newJumpTokens = totalJumpTokenCount - _processedJumpTokenCount;
    final jumpsToDispatch = newJumpTokens.clamp(0, _maxJumpsPerResult);

    // #region agent log
    debugPrint(
      'Voice jump token delta => total:$totalJumpTokenCount '
      'processed:$_processedJumpTokenCount new:$newJumpTokens '
      'dispatch:$jumpsToDispatch',
    );
    // #endregion

    if (jumpsToDispatch <= 0) {
      _lastTranscript = normalizedText;
      if (result.finalResult) {
        _resetTrackingState(reason: 'final-result-no-new-jump-tokens');
      }
      return;
    }

    _lastTranscript = normalizedText;
    _processedJumpTokenCount += jumpsToDispatch;

    for (var i = 0; i < jumpsToDispatch; i++) {
      // #region agent log
      debugPrint(
        'Voice jump command fired (${i + 1}/$jumpsToDispatch): '
        '"$normalizedText"',
      );
      // #endregion
      onJumpCommand();
    }

    if (newJumpTokens > _maxJumpsPerResult) {
      // #region agent log
      debugPrint(
        'Voice jump token delta clamped to $_maxJumpsPerResult '
        '(raw delta: $newJumpTokens)',
      );
      // #endregion
    }

    if (result.finalResult) {
      _resetTrackingState(reason: 'final-result');
    }
  }

  void _resetTrackingState({required String reason}) {
    if (_lastTranscript.isEmpty && _processedJumpTokenCount == 0) {
      return;
    }
    _lastTranscript = '';
    _processedJumpTokenCount = 0;

    // #region agent log
    debugPrint('Voice jump tracker reset ($reason)');
    // #endregion
  }

  bool get isListening => _isListening;
  bool get isAvailable => _speech.isAvailable;
  bool get isInitialized => _isInitialized;

  void dispose() {
    unawaited(stopListening());
  }
}
