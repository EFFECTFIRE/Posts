import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysql1/mysql1.dart';

class UserData extends Equatable {
  const UserData._({this.email, this.name, required this.uid});

  factory UserData.fromMySQL(Results result) {
    var results = result.toList();
    return UserData._(
        uid: results[0].values![0].toString(),
        name: results[0].values![1].toString(),
        email: results[0].values![2].toString());
  }

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
