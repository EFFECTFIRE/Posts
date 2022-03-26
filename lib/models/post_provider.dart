import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_infinite_list/models/post_data.dart';
import 'package:flutter_infinite_list/models/registration/failures.dart';

class PostProvider {
  static final _instance = FirebaseFirestore.instance;
  Future<Either<NoteFailure, List<PostData>>> getPosts() async {
    try {
      return right(await _instance.collection("posts").get().then((value) =>
          value.docs.map((post) => PostData.fromJson(post.data())).toList()));
    } catch (e) {
      return left(const NoteFailure.fromCode("Error of getting post list"));
    }
  }

  Future<Either<NoteFailure, Unit>> addPost(PostData post) async {
    try {
      await _instance.collection("posts").add(post.toJson());
      return right(unit);
    } catch (e) {
      return left(const NoteFailure.fromCode("Adding post failure"));
    }
  }

  Future<Either<NoteFailure, Unit>> deletePost(String id) async {
    try {
      await _instance.collection("posts").doc(id).delete();
      return right(unit);
    } catch (e) {
      return left(const NoteFailure.fromCode("Deleting post failure"));
    }
  }
}
