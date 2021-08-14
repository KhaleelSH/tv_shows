import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(name: 'userEmail')
  final String username;
  @JsonKey(name: 'text')
  final String comment;

  Comment({
    required this.username,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  static List<Comment> fromJsonList(List<dynamic> jsonList) {
    final List<Comment> _comments = [];
    for (final json in jsonList) {
      try {
        _comments.add(Comment.fromJson(json));
      } catch (ignored) {
        // ignore invalid comment data
      }
    }
    return _comments;
  }
}
