import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData extends Equatable {
  const UserData._({this.email, this.name, required this.uid});

  factory UserData.fromFirebase(FirebaseAuth instance) {
    return UserData._(
        uid: instance.currentUser!.uid,
        email: instance.currentUser!.email,
        name: instance.currentUser!.displayName);
  }
  final String uid;
  final String? email;
  final String? name;

  @override
  List<Object?> get props => [uid, email, name];
}
