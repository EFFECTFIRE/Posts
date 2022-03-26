import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/auth/auth_bloc.dart';
import 'package:flutter_infinite_list/bloc/post/list_bloc.dart';
import 'package:flutter_infinite_list/presentation/auth/auth_page.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => PostBloc()..add(PostFetched())),
      BlocProvider(create: (context) => AuthBloc()..add(SignOutEvent()))
    ],
    child: App(),
  ));
}

class App extends MaterialApp {
  App({Key? key})
      : super(
          key: key,
          home: AuthPage(),
        );
}
