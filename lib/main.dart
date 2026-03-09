import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_league_live/firebase_options.dart';
import 'package:local_league_live/ui/screens/home_screen.dart';
import 'package:local_league_live/ui/screens/login_screen.dart';
import 'package:local_league_live/ui/screens/match_detail_screen.dart';
import 'package:local_league_live/ui/screens/scorer_dashboard.dart';
import 'package:local_league_live/ui/screens/scoring_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const LocalLeagueLiveApp());
  } catch (e) {
    runApp(LocalLeagueLiveErrorApp(error: e.toString()));
  }
}

class LocalLeagueLiveErrorApp extends StatelessWidget {
  final String error;

  const LocalLeagueLiveErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Failed to initialize Firebase:\n$error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class LocalLeagueLiveApp extends StatelessWidget {
  const LocalLeagueLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local League Live',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }

        if (settings.name == '/match-detail') {
          final String matchId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => MatchDetailScreen(matchId: matchId),
          );
        }

        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        }

        if (settings.name == '/scorer-dashboard') {
          return MaterialPageRoute(
            builder: (context) =>
                AuthGate(child: const ScorerDashboardScreen()),
          );
        }

        if (settings.name == '/scoring') {
          final String matchId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) =>
                AuthGate(child: ScoringScreen(matchId: matchId)),
          );
        }

        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  final Widget child;

  const AuthGate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        return child;
      },
    );
  }
}