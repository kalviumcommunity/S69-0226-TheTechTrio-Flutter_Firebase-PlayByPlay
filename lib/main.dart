import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase not initialized yet: $e");
  }

  runApp(
    const ProviderScope(
      child: PlayByPlayApp(),
    ),
  );
}

class PlayByPlayApp extends ConsumerWidget {
  const PlayByPlayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'PlayByPlay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C853), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
