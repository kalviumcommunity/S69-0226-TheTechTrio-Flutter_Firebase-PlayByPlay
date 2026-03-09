import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tournament.dart';
import '../models/team.dart';
import '../models/match.dart';
import '../models/event.dart';
import 'package:flutter/foundation.dart';

class SeedService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> seedMockData() async {
    debugPrint("Seeding mock data...");

    // 1. Create Tournament
    DocumentReference tournamentRef = _db.collection('tournaments').doc();
    TournamentModel tournament = TournamentModel(
      id: tournamentRef.id,
      name: "Summer Community Cup 2026",
      location: "Riverside Cricket Ground",
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 14)),
      isCurrent: true,
    );
    await tournamentRef.set(tournament.toMap());

    // 2. Create Teams
    DocumentReference teamARef = _db.collection('teams').doc();
    TeamModel teamA = TeamModel(
      id: teamARef.id,
      tournamentId: tournament.id,
      name: "Thunder Strikers",
      shortName: "THU",
    );
    await teamARef.set(teamA.toMap());

    DocumentReference teamBRef = _db.collection('teams').doc();
    TeamModel teamB = TeamModel(
      id: teamBRef.id,
      tournamentId: tournament.id,
      name: "Lightning Bolts",
      shortName: "LIG",
    );
    await teamBRef.set(teamB.toMap());

    // 3. Create a Live Match
    DocumentReference matchRef = _db.collection('matches').doc();
    MatchModel match = MatchModel(
      id: matchRef.id,
      tournamentId: tournament.id,
      teamAId: teamA.shortName,
      teamBId: teamB.shortName,
      venue: tournament.location,
      startTime: DateTime.now(),
      status: 'live',
      currentInnings: 1,
      scoreA: MatchScore(runs: 45, wickets: 2, overs: 5.4),
      scoreB: MatchScore(runs: 0, wickets: 0, overs: 0.0),
    );
    await matchRef.set(match.toMap());

    // 4. Create an Upcoming Match
    DocumentReference upcomingMatchRef = _db.collection('matches').doc();
    MatchModel upcomingMatch = MatchModel(
      id: upcomingMatchRef.id,
      tournamentId: tournament.id,
      teamAId: "EAG",
      teamBId: "SHA",
      venue: "Highland Park",
      startTime: DateTime.now().add(const Duration(days: 1)),
      status: 'upcoming',
      currentInnings: 1,
      scoreA: MatchScore(runs: 0, wickets: 0, overs: 0.0),
      scoreB: MatchScore(runs: 0, wickets: 0, overs: 0.0),
    );
    await upcomingMatchRef.set(upcomingMatch.toMap());

    // 5. Seed some initial events for the Live Match
    DocumentReference event1Ref = _db.collection('events').doc();
    await event1Ref.set(EventModel(
      id: event1Ref.id,
      matchId: match.id,
      innings: 1,
      overNumber: 5,
      ballInOver: 3,
      runs: 4,
      isWicket: false,
      description: "Great boundary shot!",
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ).toMap());

    DocumentReference event2Ref = _db.collection('events').doc();
    await event2Ref.set(EventModel(
      id: event2Ref.id,
      matchId: match.id,
      innings: 1,
      overNumber: 5,
      ballInOver: 4,
      runs: 0,
      isWicket: true,
      description: "Clean Bowled!",
      createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
    ).toMap());

    debugPrint("Mock data seeded successfully.");
  }
}
