import 'package:json_annotation/json_annotation.dart';

part 'show.g.dart';

@JsonSerializable()
class Show {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String? description;
  final String imageUrl;

  Show({
    required this.id,
    required this.title,
    this.description,
    required this.imageUrl,
  });

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);

  Map<String, dynamic> toJson() => _$ShowToJson(this);

  /// [copyWithFixedImageUrl] Copy [Show] object with correct Image URL.
  Show copyWithFixedImageUrl({required String imageUrl}) {
    return Show(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }

  static List<Show> fromJsonList(List<dynamic> jsonList) {
    final List<Show> _shows = [];
    for (final json in jsonList) {
      try {
        _shows.add(Show.fromJson(json));
      } catch (ignored) {
        // ignore invalid show data
      }
    }
    return _shows;
  }
}
