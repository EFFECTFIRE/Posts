import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/post/list_bloc.dart';
import 'package:flutter_infinite_list/models/post_data.dart';

class PostListItem extends StatelessWidget {
  final PostData post;
  double _left = 0;

  PostListItem({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: _left,
        child: GestureDetector(
          onPanUpdate: (details) {
            _left = max(0, _left += details.delta.dx);
          },
          onPanCancel: () {
            BlocProvider.of<PostBloc>(context).add(PostDeleted(id: post.id));
            Future.delayed(Duration(milliseconds: 20), () {
              BlocProvider.of<PostBloc>(context).add(PostFetched());
            });
          },
          child: ListTile(
            title: Text(post.title),
            isThreeLine: true,
            subtitle: Text(post.body),
            dense: true,
          ),
        ),
      ),
    ]);
  }
}
