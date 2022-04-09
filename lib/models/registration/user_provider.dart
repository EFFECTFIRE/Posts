import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_infinite_list/models/registration/failures.dart';
import 'package:flutter_infinite_list/models/registration/user_model.dart';
import 'package:flutter_infinite_list/mysql.dart';
import 'package:mysql1/mysql1.dart';

class UserProvider {
  final _instance = FirebaseAuth.instance;
  final random = Random();
  final _mySql = MySql();
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

  Future<Either<AuthFailure, UserData>> signInWithMySQL(
      String email, String password) async {
    Results result = await _mySql.connection!.query(
        "SELECT * FROM users WHERE email = ? AND password = ?",
        [email, password]);
    UserData currentUser;
    if (result.isNotEmpty) {
      currentUser = UserData.fromMySQL(result);
      return right(currentUser);
    } else {
      return left(AuthFailure.fromCode("Auth Failure"));
    }
  }

  Future<Either<AuthFailure, Unit>> signOutWithMySQL() async {
    if (_mySql.connection != null) {
      //something else for sign out of account
      return right(unit);
    } else {
      return left(AuthFailure.fromCode("connection not exist"));
    }
  }

  Future<Either<AuthFailure, Unit>> signUpWithMySQL(
      String email, String password, String displayName) async {
    try {
      await _mySql.connection!.query(
          "INSERT INTO users (id, nickname, password, email) VALUES (?,?,?,?)",
          [random.nextInt(100), displayName, password, email]);
      return right(unit);
    } on MySqlException catch (e) {
      return left(AuthFailure.fromCode(e.errorNumber.toString()));
    }
  }

  Future<Either<AuthFailure, Unit>> changeNameWithMySQL(
      String displayName) async {
    try {
      await _mySql.connection!.query(
          "UPDATE users SET nickname = ? WHERE email = ?",
          [displayName, "test@mail.ru"]);
      return right(unit);
    } on MySqlException catch (e) {
      return left(AuthFailure.fromCode(e.errorNumber.toString()));
    }
  }
}
