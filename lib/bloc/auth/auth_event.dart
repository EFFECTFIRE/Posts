part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  SignInEvent(String email, String password) {
    _email = email;
    _password = password;
  }

  late String _email;
  String get email => _email;
  late String _password;
  String get password => _password;
}

class SignUpEvent extends AuthEvent {
  SignUpEvent(String email, String password, String displayName) {
    _email = email;
    _password = password;
    _displayName = displayName;
  }
  late String _email;
  String get email => _email;
  late String _password;
  String get password => _password;
  late String _displayName;
  String get displayName => _displayName;
}

class SignOutEvent extends AuthEvent {}

class ChangeNameEvent extends AuthEvent {
  ChangeNameEvent({required this.displayName});
  final String displayName;
}
