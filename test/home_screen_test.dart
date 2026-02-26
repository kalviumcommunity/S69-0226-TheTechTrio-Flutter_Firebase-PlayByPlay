import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/ui/screens/home_screen.dart';
import 'package:playbyplay/data/models/match.dart';
import 'package:playbyplay/logic/match_provider.dart';
import 'package:playbyplay/logic/auth_provider.dart';

void main() {
  testWidgets('HomeScreen MatchListFeed renders LIVE matches from mocked stream', (WidgetTester tester) async {
    // 1. Arrange: Create mock match data
    final mockMatches = [
      MatchModel(
        id: '1',
        tournamentId: 't1',
        teamAId: 'ta1',
        teamBId: 'tb1',
        teamAName: 'Eagles',
        teamBName: 'Tigers',
        startTime: DateTime.now(),
        status: 'LIVE',
        scoreTeamA: 2,
        scoreTeamB: 1,
        groundName: 'Central Field',
      ),
    ];

    // 2. Act: Pump the Widget with ProviderScope overriding the stream provider
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override Auth State to appear logged out so we don't try to load complex UI
          authStateProvider.overrideWith((ref) => const Stream.empty()),
          currentUserProfileProvider.overrideWith((ref) => Future.value(null)),
          // Override the Match list feed explicitly for the 'LIVE' status
          matchesByStatusProvider('LIVE').overrideWith((ref) => Stream.value(mockMatches)),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: MatchListFeed(status: 'LIVE'),
          ),
        ),
      ),
    );

    // Initial render is likely Loading, so we must pump to let the Stream emit
    await tester.pumpAndSettle();

    // 3. Assert: Check if the mock team names and scores appear on the screen
    expect(find.text('Eagles'), findsOneWidget);
    expect(find.text('Tigers'), findsOneWidget);
    expect(find.text('2 - 1'), findsOneWidget);
    expect(find.text('Central Field • LIVE'), findsOneWidget);
  });
}
