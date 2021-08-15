import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/pages/add_episode_page.dart';
import 'package:tv_shows/pages/comments_page.dart';
import 'package:tv_shows/pages/episode_details_page.dart';
import 'package:tv_shows/pages/initial_page.dart';
import 'package:tv_shows/pages/login_page.dart';
import 'package:tv_shows/pages/show_details_page.dart';
import 'package:tv_shows/pages/shows_page.dart';

class AppRoutes {
  static const String initial = 'initial';
  static const String login = 'login';
  static const String shows = 'shows';
  static const String showDetails = 'showDetails';
  static const String episodeDetails = 'episodeDetails';
  static const String comments = 'comments';
  static const String addEpisode = 'addEpisode';

  /// [generateRoutes] defines app routes and passes the correct arguments.
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    final dynamic args = routeSettings.arguments;
    return MaterialPageRoute(builder: (_) {
      switch (routeSettings.name) {
        case 'initial':
          return const InitialPage();
        case 'login':
          return const LoginPage();
        case 'shows':
          return const ShowsPage();
        case 'showDetails':
          return const ShowDetailsPage();
        case 'episodeDetails':
          return EpisodeDetailsPage(episode: args);
        case 'comments':
          return CommentsPage(episodeId: args);
        case 'addEpisode':
          return AddEpisodePage(show: args);
        default:
          return const LoginPage();
      }
    });
  }
}
