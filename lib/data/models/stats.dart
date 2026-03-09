class TeamStats {
  final String teamId;
  final String teamName;
  final int matchesPlayed;
  final int wins;
  final int losses;
  final int points; // e.g., 2 points for win, 0 for loss

  TeamStats({
    required this.teamId,
    required this.teamName,
    this.matchesPlayed = 0,
    this.wins = 0,
    this.losses = 0,
    this.points = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'teamId': teamId,
      'teamName': teamName,
      'matchesPlayed': matchesPlayed,
      'wins': wins,
      'losses': losses,
      'points': points,
    };
  }
}

class PlayerBattingStats {
  final String playerId;
  final String? playerName; // Making it optional depending on available data
  final int totalRuns;
  final int ballsFaced;

  PlayerBattingStats({
    required this.playerId,
    this.playerName,
    this.totalRuns = 0,
    this.ballsFaced = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'playerId': playerId,
      'playerName': playerName,
      'totalRuns': totalRuns,
      'ballsFaced': ballsFaced,
    };
  }
}
