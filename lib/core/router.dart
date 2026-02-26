import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/auth_provider.dart';

// Screens
import '../ui/screens/auth_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/tournament_dashboard.dart';
import '../ui/screens/tournament_detail_screen.dart';
import '../ui/screens/match_detail_screen.dart';
import 'package:playbyplay/data/models/tournament.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    // Redirect logic
    redirect: (context, state) {
      // If we are loading the initial auth state, don't redirect yet
      if (authState.isLoading) return null;

      final isAuth = authState.value != null;
      final isGoingToAuth = state.matchedLocation == '/auth';

      // If we are logged in but trying to hit the auth page, go home
      if (isAuth && isGoingToAuth) {
        return '/';
      }

      // We do not force auth for the home page (spectators don't need login)
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/tournaments',
        builder: (context, state) => const TournamentDashboard(),
      ),
      GoRoute(
        path: '/tournament/:id',
        builder: (context, state) {
          final tournament = state.extra as Tournament;
          return TournamentDetailScreen(tournament: tournament);
        },
      ),
      GoRoute(
        path: '/match/:id',
        builder: (context, state) {
          final matchId = state.pathParameters['id']!;
          return MatchDetailScreen(matchId: matchId);
        },
      ),
    ],
  );
});
