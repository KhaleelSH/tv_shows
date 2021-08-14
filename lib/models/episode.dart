import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  @JsonKey(name: '_id')
  final String id;
  final String? title;
  final String? description;
  final String? imageUrl;
  @JsonKey(name: 'season')
  final String seasonNumber;
  final String episodeNumber;

  Episode({
    required this.id,
    this.title,
    this.description,
    this.imageUrl,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  Episode copyWithFixedImageUrl({required String imageUrl}) {
    return Episode(
      id: id,
      title: title,
      description: description,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      imageUrl: imageUrl,
    );
  }

  static List<Episode> fromJsonList(List<dynamic> jsonList) {
    final List<Episode> _episodes = [];
    for (final json in jsonList) {
      try {
        final episode = Episode.fromJson(json);
        // This is here to filter out invalid season and episode numbers
        int.parse(episode.seasonNumber, radix: 10);
        int.parse(episode.episodeNumber, radix: 10);
        _episodes.add(Episode.fromJson(json));
      } catch (ignored) {
        // ignore invalid episode data
      }
    }
    return _episodes;
  }
}
