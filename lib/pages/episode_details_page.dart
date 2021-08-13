import 'package:flutter/material.dart';
import 'package:tv_shows/pages/comments_page.dart';
import 'package:tv_shows/utils/tv_shows_icons.dart';
import 'package:tv_shows/widgets/back_button_app_bar.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage({Key? key}) : super(key: key);

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
                      'https://i.ytimg.com/vi/MJuFdpVCcsY/movieposter_en.jpg',
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
                        'Garden Party',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'S02 E06',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Andy claims to be throwing a garden party at Dwight\'s farm to impress Robert California, but he\'s really doing it to win the approval of his parents, who appear to favor his younger brother.',
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
