import 'package:sqflite/sqflite.dart';
import 'package:super_dash/models/local_score.dart';
import 'package:super_dash/services/database/database_service.dart';

/// Repository for managing local game scores in SQLite database
class LocalScoresRepository {
  final DatabaseService _databaseService;

  LocalScoresRepository({required DatabaseService databaseService})
      : _databaseService = databaseService;

  /// Add a new score to the database
  Future<int> addScore(LocalScore score) async {
    final db = await _databaseService.database;
    return db.insert(
      DatabaseService.tableScores,
      score.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all scores sorted by score (descending)
  Future<List<LocalScore>> getAllScores() async {
    final db = await _databaseService.database;
    final maps = await db.query(
      DatabaseService.tableScores,
      orderBy: '${DatabaseService.columnScore} DESC',
    );
    return [for (final map in maps) LocalScore.fromJson(map)];
  }

  /// Get top scores with limit
  Future<List<LocalScore>> getTopScores({int limit = 10}) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      DatabaseService.tableScores,
      orderBy: '${DatabaseService.columnScore} DESC',
      limit: limit,
    );
    return [for (final map in maps) LocalScore.fromJson(map)];
  }

  /// Get scores by player
  Future<List<LocalScore>> getScoresByPlayer(String playerId) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      DatabaseService.tableScores,
      where: '${DatabaseService.columnPlayerId} = ?',
      whereArgs: [playerId],
      orderBy: '${DatabaseService.columnScore} DESC',
    );
    return [for (final map in maps) LocalScore.fromJson(map)];
  }

  /// Get scores by player name
  Future<List<LocalScore>> getScoresByPlayerName(String playerName) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      DatabaseService.tableScores,
      where: '${DatabaseService.columnPlayerName} = ?',
      whereArgs: [playerName],
      orderBy: '${DatabaseService.columnScore} DESC',
    );
    return [for (final map in maps) LocalScore.fromJson(map)];
  }

  /// Get scores within a date range
  Future<List<LocalScore>> getScoresByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      DatabaseService.tableScores,
      where: '${DatabaseService.columnPlayedAt} BETWEEN ? AND ?',
      whereArgs: [
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      ],
      orderBy: '${DatabaseService.columnPlayedAt} DESC',
    );
    return [for (final map in maps) LocalScore.fromJson(map)];
  }

  /// Get high score (maximum score)
  Future<LocalScore?> getHighScore() async {
    final db = await _databaseService.database;
    final maps = await db.query(
      DatabaseService.tableScores,
      orderBy: '${DatabaseService.columnScore} DESC',
      limit: 1,
    );
    return maps.isEmpty ? null : LocalScore.fromJson(maps.first);
  }

  /// Get recent scores (last N games)
  Future<List<LocalScore>> getRecentScores({int limit = 5}) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      DatabaseService.tableScores,
      orderBy: '${DatabaseService.columnPlayedAt} DESC',
      limit: limit,
    );
    return [for (final map in maps) LocalScore.fromJson(map)];
  }

  /// Get average score for a player
  Future<double?> getAverageScoreForPlayer(String playerId) async {
    final db = await _databaseService.database;
    final result = await db.rawQuery(
      '''
      SELECT AVG(${DatabaseService.columnScore}) as avg_score
      FROM ${DatabaseService.tableScores}
      WHERE ${DatabaseService.columnPlayerId} = ?
      ''',
      [playerId],
    );
    final avgScore = result.first['avg_score'];
    return avgScore is num ? avgScore.toDouble() : null;
  }

  /// Count total scores
  Future<int> getScoresCount() async {
    final db = await _databaseService.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseService.tableScores}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Count scores for a player
  Future<int> getScoresCountForPlayer(String playerId) async {
    final db = await _databaseService.database;
    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as count FROM ${DatabaseService.tableScores}
      WHERE ${DatabaseService.columnPlayerId} = ?
      ''',
      [playerId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Update a score
  Future<int> updateScore(LocalScore score) async {
    final db = await _databaseService.database;
    return db.update(
      DatabaseService.tableScores,
      score.toJson(),
      where: '${DatabaseService.columnId} = ?',
      whereArgs: [score.id],
    );
  }

  /// Delete a score by ID
  Future<int> deleteScore(int id) async {
    final db = await _databaseService.database;
    return db.delete(
      DatabaseService.tableScores,
      where: '${DatabaseService.columnId} = ?',
      whereArgs: [id],
    );
  }

  /// Delete all scores
  Future<int> deleteAllScores() async {
    final db = await _databaseService.database;
    return db.delete(DatabaseService.tableScores);
  }

  /// Delete scores older than a specific date
  Future<int> deleteScoresOlderThan(DateTime date) async {
    final db = await _databaseService.database;
    return db.delete(
      DatabaseService.tableScores,
      where: '${DatabaseService.columnPlayedAt} < ?',
      whereArgs: [date.toIso8601String()],
    );
  }

  /// Export scores to JSON format
  Future<List<Map<String, dynamic>>> exportScoresToJson() async {
    final scores = await getAllScores();
    return [for (final score in scores) score.toJson()];
  }

  /// Close database connection
  Future<void> closeDatabase() => _databaseService.closeDatabase();
}
