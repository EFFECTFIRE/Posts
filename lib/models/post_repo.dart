import 'package:dartz/dartz.dart';
import 'package:flutter_infinite_list/models/post_data.dart';
import 'package:flutter_infinite_list/models/post_provider.dart';
import 'package:flutter_infinite_list/models/registration/auth_facade.dart';
import 'package:flutter_infinite_list/models/registration/failures.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  PostRepository();
  static Uuid uuid = const Uuid();
  final PostProvider _postProvider = PostProvider();
  final AuthFacade authFacade = AuthFacade();

  Future<Either<NoteFailure, List<PostData>>> getAllPosts() async {
    return await _postProvider.getPosts();
  }

  Future<Either<NoteFailure, Unit>> addPost(PostData post) async {
    return await _postProvider.addPost(post);
  }

  Future<Either<NoteFailure, Unit>> deletePost(String id) async {
    return await _postProvider.deletePost(id);
  }
}
