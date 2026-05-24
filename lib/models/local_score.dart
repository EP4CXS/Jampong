import 'package:equatable/equatable.dart';

/// Model for locally stored game scores in SQLite
class LocalScore extends Equatable {
  const LocalScore({
    this.id,
    required this.playerId,
    required this.playerName,
    required this.score,
    this.level,
    this.difficulty,
    this.gameDuration,
    this.enemiesDefeated,
    this.powerUpsCollected,
    required this.playedAt,
  });

  final int? id;
  final String? playerId;
  final String playerName;
  final int score;
  final int? level;
  final String? difficulty; // 'easy', 'medium', 'hard'
  final int? gameDuration; // in seconds
  final int? enemiesDefeated;
  final int? powerUpsCollected;
  final DateTime playedAt;

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'player_id': playerId,
      'player_name': playerName,
      'score': score,
      'level': level,
      'difficulty': difficulty,
      'game_duration': gameDuration,
      'enemies_defeated': enemiesDefeated,
      'power_ups_collected': powerUpsCollected,
      'played_at': playedAt.toIso8601String(),
    };
  }

  /// Create from database JSON
  factory LocalScore.fromJson(Map<String, dynamic> json) {
    return LocalScore(
      id: json['id'] as int?,
      playerId: json['player_id'] as String?,
      playerName: json['player_name'] as String,
      score: json['score'] as int,
      level: json['level'] as int?,
      difficulty: json['difficulty'] as String?,
      gameDuration: json['game_duration'] as int?,
      enemiesDefeated: json['enemies_defeated'] as int?,
      powerUpsCollected: json['power_ups_collected'] as int?,
      playedAt: DateTime.parse(json['played_at'] as String),
    );
  }

  LocalScore copyWith({
    int? id,
    String? playerId,
    String? playerName,
    int? score,
    int? level,
    String? difficulty,
    int? gameDuration,
    int? enemiesDefeated,
    int? powerUpsCollected,
    DateTime? playedAt,
  }) {
    return LocalScore(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      score: score ?? this.score,
      level: level ?? this.level,
      difficulty: difficulty ?? this.difficulty,
      gameDuration: gameDuration ?? this.gameDuration,
      enemiesDefeated: enemiesDefeated ?? this.enemiesDefeated,
      powerUpsCollected: powerUpsCollected ?? this.powerUpsCollected,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        playerId,
        playerName,
        score,
        level,
        difficulty,
        gameDuration,
        enemiesDefeated,
        powerUpsCollected,
        playedAt,
      ];
}
