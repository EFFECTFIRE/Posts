part of 'list_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class PostCreated extends PostEvent {
  PostCreated({required this.title, required this.body});
  String title;
  String body;
}

class PostDeleted extends PostEvent {
  PostDeleted({required this.id});
  String id;
}
