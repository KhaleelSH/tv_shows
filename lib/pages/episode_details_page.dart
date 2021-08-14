import 'package:flutter/material.dart';
import 'package:tv_shows/models/episode.dart';
import 'package:tv_shows/pages/comments_page.dart';
import 'package:tv_shows/utils/tv_shows_icons.dart';
import 'package:tv_shows/widgets/back_button_app_bar.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      episode.imageUrl!,
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/image_placeholder_episodes.png',
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                        );
                      },
                    ),
                    Positioned.fill(
                      bottom: -1,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.transparent,
                            ],
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset(0.5, 0.75),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        (episode.title?.isEmpty ?? true)
                            ? 'No Title'
                            : episode.title!,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'S${episode.seasonNumber.padLeft(2, '0')} E${episode.episodeNumber.padLeft(2, '0')}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        (episode.description?.isEmpty ?? true)
                            ? 'No Description'
                            : episode.description!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BackButtonAppBar(),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const CommentsPage()));
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          title: Row(
            children: <Widget>[
              const Icon(TVShowsIcons.comments),
              const SizedBox(width: 8),
              Text(
                'Comments',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
