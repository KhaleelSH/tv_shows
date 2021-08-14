import 'dart:convert' show json;

import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:tv_shows/models/episode.dart';
import 'package:tv_shows/models/show.dart';

class ApiDataClient {
  ApiDataClient() {
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
}
