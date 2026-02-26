import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/data/models/user.dart';
import 'package:playbyplay/data/repositories/auth_repository.dart';

// Stream of just the raw Firebase authentication state (logged in or out)
final authStateProvider = StreamProvider<String?>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges.map((firebaseUser) => firebaseUser?.uid);
});

// A provider that fetches and caches the fully hydrated User profile (with role) from Firestore
final currentUserProfileProvider = FutureProvider<User?>((ref) {
  final uid = ref.watch(authStateProvider).value;
  if (uid == null) return null;
  return ref.watch(authRepositoryProvider).getUserProfile(uid);
});

// StateNotifier to handle loading states during manual login/signup actions
class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _repo;

  AuthController(this._repo) : super(const AsyncData(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    try {
      await _repo.signIn(email, password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e.toString(), st);
    }
  }

  Future<void> signUp(String email, String password, String name, String role) async {
    state = const AsyncLoading();
    try {
      await _repo.signUp(email, password, name, role);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e.toString(), st);
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthController(repo);
});
