import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/auth/auth_bloc.dart';
import 'package:flutter_infinite_list/bloc/post/list_bloc.dart';
import 'package:flutter_infinite_list/presentation/post_list.dart';

part 'post_create_dialog.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
          leading: IconButton(
            onPressed: () => showDialog<void>(
                context: context,
                builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<PostBloc>(context),
                    child: const PostCreateDialog())),
            icon: const Icon(Icons.add),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                  Navigator.pop(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: const PostList());
  }
}
