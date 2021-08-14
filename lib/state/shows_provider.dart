import 'package:flutter/material.dart';
import 'package:tv_shows/data/data_client.dart';
import 'package:tv_shows/models/comment.dart';
import 'package:tv_shows/models/episode.dart';
import 'package:tv_shows/models/show.dart';

class ShowsProvider extends ChangeNotifier {
  final DataClient client;

  ShowsProvider(this.client);

  bool _loadingShows = false;
  bool _loadingCurrentSelectedShowDescription = true;
  bool _loadingCurrentSelectedShowEpisodes = true;

  List<Show> _shows = [];
  Show? _currentSelectedShow;
  String? _currentSelectedShowDescription;
  List<Episode> _currentSelectedShowEpisodes = [];

  bool get loadingShows => _loadingShows;

  bool get loadingCurrentSelectedShowDescription =>
      _loadingCurrentSelectedShowDescription;

  bool get loadingCurrentSelectedShowEpisodes =>
      _loadingCurrentSelectedShowEpisodes;

  List<Show> get shows => _shows;

  Show? get currentSelectedShow => _currentSelectedShow;

  String? get currentSelectedShowDescription => _currentSelectedShowDescription;

  List<Episode> get currentSelectedShowEpisodes => _currentSelectedShowEpisodes;

  Future<void> getShows({bool showLoading = true}) async {
    try {
      if (showLoading) {
        _loadingShows = true;
        notifyListeners();
      }
      _shows = await client.api.getShows();
    } catch (e) {
      rethrow;
    } finally {
      _loadingShows = false;
      notifyListeners();
    }
  }

  void setCurrentSelectedShow(Show show) {
    _currentSelectedShow = show;
    notifyListeners();
  }

  void clearCurrentSelectedShow() {
    _currentSelectedShow = null;
    _currentSelectedShowDescription = null;
    _currentSelectedShowEpisodes = [];
  }

  Future<void> getShowDescription({bool showLoading = true}) async {
    try {
      if (showLoading) {
        _loadingCurrentSelectedShowDescription = true;
        notifyListeners();
      }
      _currentSelectedShowDescription =
          await client.api.getShowDescription(currentSelectedShow!.id);
    } catch (e) {
      rethrow;
    } finally {
      _loadingCurrentSelectedShowDescription = false;
      notifyListeners();
    }
  }

  Future<void> getShowEpisodes({bool showLoading = true}) async {
    try {
      if (showLoading) {
        _loadingCurrentSelectedShowEpisodes = true;
        notifyListeners();
      }
      _currentSelectedShowEpisodes =
          await client.api.getShowEpisodes(currentSelectedShow!.id);
    } catch (e) {
      rethrow;
    } finally {
      _loadingCurrentSelectedShowEpisodes = false;
      notifyListeners();
    }
  }

  Future<List<Comment>> getEpisodeComments({required String episodeId}) async {
    try {
      return await client.api.getEpisodeComments(episodeId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNewComment(
      {required String text, required String episodeId}) async {
    try {
      return await client.api.addNewComment(text, episodeId);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImage({required String filePath}) async {
    try {
      return await client.api.uploadImage(filePath);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNewEpisode({
    required String showId,
    required String mediaId,
    required String title,
    required String description,
    required String episodeNumber,
    required String seasonNumber,
  }) async {
    try {
      return await client.api.addNewEpisode(
          showId, mediaId, title, description, episodeNumber, seasonNumber);
    } catch (e) {
      rethrow;
    }
  }
}
