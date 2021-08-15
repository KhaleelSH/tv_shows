import 'dart:convert' show json;

import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:tv_shows/models/comment.dart';
import 'package:tv_shows/models/episode.dart';
import 'package:tv_shows/models/show.dart';

/// [ApiDataClient] handles all network calls and API communication.
class ApiDataClient {
  ApiDataClient() {
    // Logging all http requests/responses.
    _client.interceptors.add(LoggyDioInterceptor());
  }

  static const baseUrl = 'https://api.infinum.academy/api';
  static const imagesUrl = 'https://api.infinum.academy';

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );

  void setAuthorizationHeader(String token) {
    _client.options.headers.addAll({'Authorization': token});
  }

  void clearAuthorizationHeader() {
    _client.options.headers.remove('Authorization');
  }

  Future<String> login(String email, String password) async {
    try {
      Response response = await _client.post(
        '/users/sessions',
        data: json.encode({
          'email': email,
          'password': password,
        }),
      );
      return response.data['data']['token'];
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Login Failed!';
    }
  }

  Future<List<Show>> getShows() async {
    try {
      Response response = await _client.get('/shows');
      List<Show> _tempList = Show.fromJsonList(response.data['data']);
      List<Show> _shows = <Show>[];
      for (int i = 0; i < _tempList.length; i++) {
        final show = _tempList[i];
        _shows.add(show.copyWithFixedImageUrl(
            imageUrl: '$imagesUrl/${show.imageUrl}'));
      }
      return _shows;
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Getting Shows Failed!';
    }
  }

  Future<String?> getShowDescription(String showId) async {
    try {
      Response response = await _client.get('/shows/$showId');
      final description = Show.fromJson(response.data['data']).description;
      if (description != null && description.isEmpty) {
        return 'No description found for this show.';
      }
      return Show.fromJson(response.data['data']).description;
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Getting Show Description Failed!';
    }
  }

  Future<List<Episode>> getShowEpisodes(String showId) async {
    try {
      Response response = await _client.get('/shows/$showId/episodes');
      List<Episode> _tempList = Episode.fromJsonList(response.data['data']);
      List<Episode> _episodes = <Episode>[];
      for (int i = 0; i < _tempList.length; i++) {
        final episode = _tempList[i];
        _episodes.add(episode.copyWithFixedImageUrl(
            imageUrl: '$imagesUrl/${episode.imageUrl}'));
      }
      return _episodes;
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Getting Show Episodes Failed!';
    }
  }

  Future<List<Comment>> getEpisodeComments(String episodeId) async {
    try {
      Response response = await _client.get('/episodes/$episodeId/comments');
      return Comment.fromJsonList(response.data['data']);
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Getting Episode Comments Failed!';
    }
  }

  Future<void> addNewComment(String text, String episodeId) async {
    try {
      await _client.post(
        '/comments',
        data: {
          'text': text,
          'episodeId': episodeId,
        },
      );
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Failed to post new comment!';
    }
  }

  Future<String> uploadImage(String filePath) async {
    try {
      final formData =
          FormData.fromMap({'file': await MultipartFile.fromFile(filePath)});
      Response response = await _client.post('/media', data: formData);
      return response.data['data']['_id'];
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Failed to upload image!';
    }
  }

  Future<void> addNewEpisode(
    String showId,
    String mediaId,
    String title,
    String description,
    String episodeNumber,
    String seasonNumber,
  ) async {
    try {
      Response response = await _client.post(
        '/episodes',
        data: json.encode({
          'showId': showId,
          'mediaId': mediaId,
          'title': title,
          'description': description,
          'episodeNumber': episodeNumber,
          'season': seasonNumber,
        }),
      );
      return response.data['data']['token'];
    } on DioError catch (e) {
      throw e.response?.data['errors'][0] ?? 'Failed to add new episode!';
    }
  }
}
