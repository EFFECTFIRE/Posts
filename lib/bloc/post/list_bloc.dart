import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/models/post_data.dart';
import 'package:flutter_infinite_list/models/post_repo.dart';

part 'list_event.dart';

part 'list_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<PostFetched>(_onPostFetched);
    on<PostCreated>(_onPostCreated);
    on<PostDeleted>(_onPostDeleted);
  }
  PostRepository postRepo = PostRepository();
  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final postsOrFailure = await postRepo.getAllPosts();
        postsOrFailure.fold(
            (notefailure) => emit(state.copyWith(status: PostStatus.failure)),
            (posts) => emit(state.copyWith(
                status: PostStatus.success,
                posts: posts,
                hasReachedMax: false)));
      }
      final postsOrFailure = await postRepo.getAllPosts();
      postsOrFailure.fold(
          (notefailure) => emit(state.copyWith(status: PostStatus.failure)),
          (posts) => emit(state.copyWith(
              status: PostStatus.success, posts: posts, hasReachedMax: false)));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> _onPostCreated(
      PostCreated event, Emitter<PostState> emit) async {
    try {
      await postRepo.addPost(PostData(
          id: PostRepository.uuid.v1(),
          title: event.title,
          body: event.body,
          dateTime: DateTime.now()));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> _onPostDeleted(
      PostDeleted event, Emitter<PostState> emit) async {
    try {
      await postRepo.deletePost(event.id);
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
