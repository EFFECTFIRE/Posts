import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.code);
  final String code;
  @override
  List<Object?> get props => [code];
}

class AuthFailure extends Failure {
  const AuthFailure.fromCode(String code) : super(code);
}

class NoteFailure extends Failure {
  const NoteFailure.fromCode(String code) : super(code);
}
