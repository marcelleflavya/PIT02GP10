import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String> registerAccount({
    required String name,
    required String email,
    String? phone,
    required String password,
  });

  Future<void> updateUser({
    required String name,
    required String customName,
    String? phone,
    required String password,
  });

  Future<UserCredential> login({
    required String email,
    required String password,
  });

  User? get currentUser;

  Future<void> recoveryPassword({required String email});

  Future<void> logout();
}
