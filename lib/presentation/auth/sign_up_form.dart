import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/auth/auth_bloc.dart';
import 'package:flutter_infinite_list/presentation/auth/auth_page.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  late String _email;
  late String _password;
  late String _displayName;

  final GlobalKey<FormState> _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post List"),
      ),
      body: Form(
          key: _formkey,
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
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                controller: _displayNameController,
                keyboardType: TextInputType.name,
                showCursor: true,
                onChanged: (displayName) => _displayName = displayName,
                onSaved: (displayName) => _displayName = displayName!,
                //validator: (displayName) {},
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context)
                          .add(SignUpEvent(_email, _password, _displayName));
                      Future.delayed(Duration(seconds: 5), () {
                        final state = BlocProvider.of<AuthBloc>(context).state;
                        if (state.authFailure == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.status.toString())));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthPage()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Error"),
                                    content: Text(state.authFailure!.code),
                                  ));
                        }
                      });
                    }
                  },
                  child: const Text("Create account"))
            ],
          )),
    );
  }
}
