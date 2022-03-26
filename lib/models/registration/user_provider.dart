import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_infinite_list/models/registration/failures.dart';
import 'package:flutter_infinite_list/models/registration/user_model.dart';

class UserProvider {
  final _instance = FirebaseAuth.instance;
  Future<UserData> getCurrentUser() async {
    return UserData.fromFirebase(_instance);
  }

  Future<Either<AuthFailure, Unit>> signIn(
      String email, String password) async {
    try {
      await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (exception) {
      return left(AuthFailure.fromCode(exception.code));
    }
  }

  Future<Either<AuthFailure, Unit>> signUp(
      String email, String password, String? displayName) async {
    try {
      await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
      await _instance.currentUser!.updateDisplayName(displayName);
      return right(unit);
    } on FirebaseAuthException catch (exception) {
      return left(AuthFailure.fromCode(exception.code));
    }
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _instance.signOut();
      return right(unit);
    } on FirebaseAuthException catch (exception) {
      return left(AuthFailure.fromCode(exception.code));
    }
  }

  Future<Either<AuthFailure, Unit>> changeName(String changedName) async {
    try {
      if (_instance.currentUser != null) {
        await _instance.currentUser!.updateDisplayName(changedName);
        return right(unit);
      } else {
        return left(const AuthFailure.fromCode("user-not-found"));
      }
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    }
  }
}
