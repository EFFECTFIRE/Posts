import 'package:dartz/dartz.dart';
import 'package:flutter_infinite_list/models/registration/failures.dart';
import 'package:flutter_infinite_list/models/registration/user_provider.dart';

class AuthFacade {
  AuthFacade();
  final UserProvider _userProvider = UserProvider();

  Future<Either<AuthFailure, Unit>> signIn(
      String email, String password) async {
    return await _userProvider.signIn(email, password);
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    return await _userProvider.signOut();
  }

  Future<Either<AuthFailure, Unit>> signUp(
      String email, String password, String displayName) async {
    return await _userProvider.signUp(email, password, displayName);
  }

  Future<Either<AuthFailure, Unit>> changeName(String displayName) async {
    return await _userProvider.changeName(displayName);
  }
}
