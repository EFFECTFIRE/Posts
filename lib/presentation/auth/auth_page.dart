import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/auth/auth_bloc.dart';
import 'package:flutter_infinite_list/presentation/auth/sign_in_form.dart';
import 'package:flutter_infinite_list/presentation/auth/sign_up_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post List"),
        leading: IconButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<AuthBloc>(context),
                    child: SignUpForm(),
                  )),
          icon: Icon(Icons.person_add),
        ),
      ),
      body: SignInForm(),
    );
  }
}
