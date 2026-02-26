import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/data/models/user.dart';

// Provider to inject the repository easily
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    auth.FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );
});

class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._firebaseAuth, this._firestore);

  // Stream of standard Firebase User
  Stream<auth.User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Get current user id
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  // Fetch full custom User model from Firestore
  Future<User?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return User.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch user profile: \$e');
    }
  }

  // Sign in
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserCredential(uid: cred.user!.uid, email: cred.user!.email);
    } catch (e) {
      throw Exception('Login failed: \${e.toString()}');
    }
  }

  // Sign up and create Firestore document
  Future<UserCredential> signUp(String email, String password, String name, String role) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final uid = cred.user!.uid;

      // Create the custom user document in Firestore to store role
      final newUser = User(
        id: uid,
        name: name,
        email: email,
        role: role,
      );

      await _firestore.collection('users').doc(uid).set(newUser.toJson());

      return UserCredential(uid: uid, email: email);
    } catch (e) {
      throw Exception('Signup failed: \${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

class UserCredential {
  final String uid;
  final String? email;
  UserCredential({required this.uid, this.email});
}
