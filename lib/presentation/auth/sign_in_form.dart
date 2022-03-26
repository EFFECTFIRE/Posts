import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/auth/auth_bloc.dart';
import 'package:flutter_infinite_list/presentation/bottom_loader.dart';
import 'package:flutter_infinite_list/presentation/post_page.dart';

class SignInForm extends StatelessWidget {
  SignInForm({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;

  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Email"),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              showCursor: true,
              onChanged: (email) => _email = email,
              onSaved: (email) => _email = email!,
              //validator: (email) {},
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              showCursor: true,
              onChanged: (password) => _password = password,
              onSaved: (password) => _password = password!,
              //validator: (password) {},
            ),
            ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context)
                        .add(SignInEvent(_email, _password));
                    Future.delayed(Duration(seconds: 2), () {
                      final state = BlocProvider.of<AuthBloc>(context).state;
                      if (state.authFailure != null) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Error"),
                                  content: Text(state.authFailure!.code),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"))
                                  ],
                                ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.status.toString())));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostPage()));
                      }
                    });
                  }
                },
                child: Text("Sign In"))
          ],
        ));
  }
}
