import 'package:equatable/equatable.dart';

class PostData extends Equatable {
  PostData(
      {required this.id,
      required this.title,
      required this.body,
      required this.dateTime});

  String id;
  String title;
  String body;
  DateTime dateTime;

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        dateTime: json["dateTime"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "dateTime": dateTime.toString()
    };
  }

  @override
  List<Object> get props => [id, title, body, dateTime];
}
