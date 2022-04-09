part of 'auth_bloc.dart';

enum AuthStatus { authorized, unauthorized, registred, failure }

class AuthState extends Equatable {
  AuthState({required this.status, this.authFailure, this.userData});
  AuthStatus status;
  AuthFailure? authFailure;
  UserData? userData;

  @override
  List<Object?> get props => [status, authFailure];
}
