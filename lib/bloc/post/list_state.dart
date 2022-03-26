part of 'list_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  const PostState(
      {this.status = PostStatus.initial,
      this.posts = const <PostData>[],
      this.hasReachedMax = false});

  final PostStatus status;
  final List<PostData> posts;
  final bool hasReachedMax;

  PostState copyWith(
      {PostStatus? status, List<PostData>? posts, bool? hasReachedMax}) {
    return PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() =>
      'PostState{status:$status,posts:${posts.length},hasReachedMax: $hasReachedMax}';

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
