import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final FirebaseAuth auth;

  const AuthRepository({required this.auth});

  Stream<User?> get authStateChange => auth.authStateChanges();

  User? get currentUser => auth.currentUser;

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signout() => auth.signOut();
}

@Riverpod(keepAlive: false)
AuthRepository authRepository(ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
}
