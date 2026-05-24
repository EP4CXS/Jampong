import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite Database Service for local data persistence
class DatabaseService {
  static const String _databaseName = 'jumpmong.db';
  static const int _databaseVersion = 1;

  static const String tableScores = 'scores';
  static const String columnId = 'id';
  static const String columnPlayerId = 'player_id';
  static const String columnPlayerName = 'player_name';
  static const String columnScore = 'score';
  static const String columnLevel = 'level';
  static const String columnDifficulty = 'difficulty';
  static const String columnGameDuration = 'game_duration'; // in seconds
  static const String columnEnemiesDefeated = 'enemies_defeated';
  static const String columnPowerUpsCollected = 'power_ups_collected';
  static const String columnPlayedAt = 'played_at'; // ISO 8601 timestamp

  static Database? _database;

  /// Get or initialize the database
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $tableScores (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnPlayerId TEXT,
        $columnPlayerName TEXT NOT NULL,
        $columnScore INTEGER NOT NULL,
        $columnLevel INTEGER,
        $columnDifficulty TEXT,
        $columnGameDuration INTEGER,
        $columnEnemiesDefeated INTEGER,
        $columnPowerUpsCollected INTEGER,
        $columnPlayedAt TEXT NOT NULL
      )
      ''',
    );

    // Create index for faster queries
    await db.execute(
      'CREATE INDEX idx_player_id ON $tableScores($columnPlayerId)',
    );
    await db.execute(
      'CREATE INDEX idx_played_at ON $tableScores($columnPlayedAt)',
    );
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Handle schema migrations here in future versions
  }

  /// Close the database connection
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Reset the database (for testing)
  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    await deleteDatabase(path);
    _database = null;
  }
}
