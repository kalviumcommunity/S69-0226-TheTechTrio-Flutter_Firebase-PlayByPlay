import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/ui/screens/match_detail_screen.dart';
import 'package:playbyplay/data/models/match.dart';
import 'package:playbyplay/data/models/user.dart';
import 'package:playbyplay/logic/match_provider.dart';
import 'package:playbyplay/logic/auth_provider.dart';

void main() {
  testWidgets('MatchDetailScreen shows increment buttons only for Scorer/Organizer', (WidgetTester tester) async {
    // 1. Arrange
    final mockMatch = MatchModel(
      id: 'm1',
      tournamentId: 't1',
      teamAId: 'ta1',
      teamBId: 'tb1',
      teamAName: 'Team A',
      teamBName: 'Team B',
      startTime: DateTime.now(),
      status: 'LIVE',
      scoreTeamA: 0,
      scoreTeamB: 0,
      groundName: 'Field 1',
    );

    final mockScorerUser = User(id: 'u1', name: 'Scorer', email: 's@s.com', role: 'SCORER');

    // 2. Act: Pump Widget simulating a logged-in SCORER
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProfileProvider.overrideWith((ref) => Future.value(mockScorerUser)),
          singleMatchProvider('m1').overrideWith((ref) => Stream.value(mockMatch)),
          // Mock empty stats to avoid build errors from missing subcollections
          matchStatsProvider('m1').overrideWith((ref) => const Stream.empty()),
        ],
        child: const MaterialApp(
          home: MatchDetailScreen(matchId: 'm1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 3. Assert: Since user is SCORER, they should see "Team A" and "Team B" increment buttons, and the FAB.
    expect(find.text('Team A'), findsWidgets); // Score name + Button
    expect(find.text('Team B'), findsWidgets); // Score name + Button
    expect(find.byType(FloatingActionButton), findsOneWidget); // Add Stat Button
  });

  testWidgets('MatchDetailScreen hides increment buttons for Public/Viewer', (WidgetTester tester) async {
    // 1. Arrange
    final mockMatch = MatchModel(
      id: 'm1',
      tournamentId: 't1',
      teamAId: 'ta1',
      teamBId: 'tb1',
      teamAName: 'Team A',
      teamBName: 'Team B',
      startTime: DateTime.now(),
      status: 'LIVE',
      scoreTeamA: 0,
      scoreTeamB: 0,
      groundName: 'Field 1',
    );

    // 2. Act: Pump Widget simulating a Logged Out user (Viewer)
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProfileProvider.overrideWith((ref) => Future.value(null)), // No user
          singleMatchProvider('m1').overrideWith((ref) => Stream.value(mockMatch)),
          matchStatsProvider('m1').overrideWith((ref) => const Stream.empty()),
        ],
        child: const MaterialApp(
          home: MatchDetailScreen(matchId: 'm1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 3. Assert: Buttons should not exist
    expect(find.byType(ElevatedButton), findsNothing); // Buttons to increment score
    expect(find.byType(FloatingActionButton), findsNothing); // Add Stat Button
  });
}
