part of 'auth_bloc.dart';

enum AuthStatus { authorized, unauthorized, registred, failure }

class AuthState extends Equatable {
  AuthState({required this.status, this.authFailure});
  AuthStatus status;
  AuthFailure? authFailure;

  @override
  List<Object?> get props => [status, authFailure];
}
