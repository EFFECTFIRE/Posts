import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/post/list_bloc.dart';
import 'package:flutter_infinite_list/presentation/bottom_loader.dart';
import 'package:flutter_infinite_list/presentation/post_list_item.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) =>
          BlocProvider.of<PostBloc>(context).add(PostFetched()),
      child: BlocBuilder<PostBloc, PostState>(
          bloc: BlocProvider.of<PostBloc>(context),
          builder: (context, state) {
            switch (state.status) {
              case PostStatus.failure:
                return const Center(child: Text("failed to fetch posts"));
              case PostStatus.success:
                if (state.posts.isEmpty) {
                  return const Center(
                    child: Text("no posts"),
                  );
                }

                return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PostListItem(post: state.posts[index]);
                    });
              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  void disponse() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) BlocProvider.of<PostBloc>(context).add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
