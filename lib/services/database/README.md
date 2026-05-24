# SQLite Database Integration Guide

This project now uses **SQLite** for local data persistence. The database is used to store player game scores, achievements, and statistics locally on the device.

## Setup Overview

### Files Created

1. **`lib/services/database/database_service.dart`** - Core database initialization and schema
2. **`lib/models/local_score.dart`** - Data model for scores
3. **`lib/services/database/local_scores_repository.dart`** - Repository with database operations

### Database Schema

**Table: `scores`**

| Column | Type | Purpose |
|--------|------|---------|
| `id` | INTEGER (PK) | Auto-increment primary key |
| `player_id` | TEXT | Firebase user ID or identifier |
| `player_name` | TEXT | Player display name |
| `score` | INTEGER | Game score |
| `level` | INTEGER | Level reached |
| `difficulty` | TEXT | Difficulty ('easy', 'medium', 'hard') |
| `game_duration` | INTEGER | Game duration in seconds |
| `enemies_defeated` | INTEGER | Number of enemies defeated |
| `power_ups_collected` | INTEGER | Number of power-ups collected |
| `played_at` | TEXT | ISO 8601 timestamp |

## Usage Example

```dart
import 'package:super_dash/models/local_score.dart';
import 'package:super_dash/services/database/database_service.dart';
import 'package:super_dash/services/database/local_scores_repository.dart';

// Initialize
final databaseService = DatabaseService();
final scoresRepository = LocalScoresRepository(
  databaseService: databaseService,
);

// Add a new score
final newScore = LocalScore(
  playerId: 'user123',
  playerName: 'John Doe',
  score: 1500,
  level: 5,
  difficulty: 'hard',
  gameDuration: 120,
  enemiesDefeated: 25,
  powerUpsCollected: 8,
  playedAt: DateTime.now(),
);

final scoreId = await scoresRepository.addScore(newScore);

// Get top 10 scores
final topScores = await scoresRepository.getTopScores(limit: 10);

// Get high score
final highScore = await scoresRepository.getHighScore();

// Get recent scores
final recentScores = await scoresRepository.getRecentScores(limit: 5);

// Get player's scores
final playerScores = await scoresRepository.getScoresByPlayer('user123');

// Get average score for player
final avgScore = await scoresRepository.getAverageScoreForPlayer('user123');

// Export to JSON (for DB Browser visualization)
final jsonData = await scoresRepository.exportScoresToJson();
print(jsonData);
```

## Database Location

- **Android**: `/data/data/com.example.jumpmong/databases/jumpmong.db`
- **iOS**: `~/Library/Application Support/jumpmong.db`
- **Windows**: `%APPDATA%\jumpmong.db`

## Viewing Database with DB Browser

1. Build and run the app on your device/emulator
2. Extract the `jumpmong.db` file using ADB (Android) or Xcode (iOS)
3. Open in **DB Browser for SQLite**
4. View the `scores` table to see all recorded game data

### Extract Database (Android)

```bash
adb pull /data/data/com.example.jumpmong/databases/jumpmong.db ./jumpmong.db
```

### Extract Database (iOS)

Use Xcode Device Manager or:

```bash
instruments -s devices
# Then use device console to access app container
```

## Integration with Game

To record scores after each game session, call:

```dart
await scoresRepository.addScore(
  LocalScore(
    playerId: currentUser.uid, // from Firebase
    playerName: currentUser.displayName,
    score: gameScore,
    level: levelReached,
    difficulty: gameDifficulty,
    gameDuration: gameDuration.inSeconds,
    enemiesDefeated: enemiesKilled,
    powerUpsCollected: powerUpsGrabbed,
    playedAt: DateTime.now(),
  ),
);
```

## Integration with Leaderboard

The existing Firebase leaderboard stores top 10 globally. You can now:

1. **Local**: Use SQLite for all player game history
2. **Cloud**: Sync top scores to Firebase Firestore for global leaderboard
3. **Offline**: Player can still see their local scores without internet

## Repository Methods

### Query Methods
- `getAllScores()` - Get all scores
- `getTopScores({limit})` - Get top N scores
- `getScoresByPlayer(playerId)` - Get player's scores
- `getScoresByPlayerName(playerName)` - Get scores by name
- `getScoresByDateRange(start, end)` - Get scores in date range
- `getHighScore()` - Get single highest score
- `getRecentScores({limit})` - Get last N games played

### Analytics Methods
- `getAverageScoreForPlayer(playerId)` - Player average score
- `getScoresCount()` - Total scores recorded
- `getScoresCountForPlayer(playerId)` - Count for specific player

### Data Management
- `addScore(score)` - Insert new score
- `updateScore(score)` - Update existing score
- `deleteScore(id)` - Delete single score
- `deleteAllScores()` - Clear all data
- `deleteScoresOlderThan(date)` - Cleanup old data
- `exportScoresToJson()` - Export for backup/visualization

## Testing with DB Browser

After running the app and collecting some scores, use DB Browser to:

1. **View raw data**: Browse the `scores` table
2. **Create custom queries**: Filter by date, player, score range
3. **Export**: Export data to CSV/JSON for analysis
4. **Modify**: Edit test data directly for testing

## Next Steps

1. ✅ SQLite setup complete
2. TODO: Integrate into game end screen to save scores
3. TODO: Create UI to display local score history
4. TODO: Add sync mechanism between local SQLite and Firebase
5. TODO: Add data export/import functionality
