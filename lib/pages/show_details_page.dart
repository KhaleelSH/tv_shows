import 'package:flutter/material.dart';
import 'package:tv_shows/pages/add_episode_page.dart';
import 'package:tv_shows/pages/episode_details_page.dart';
import 'package:tv_shows/utils/app_colors.dart';
import 'package:tv_shows/widgets/adaptive_refresh_indicator.dart';
import 'package:tv_shows/widgets/back_button_app_bar.dart';
import 'package:tv_shows/widgets/episode_tile.dart';

class ShowDetailsPage extends StatelessWidget {
  const ShowDetailsPage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AdaptiveRefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 5));
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'show_image_$name',
                    child: Stack(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'The Office',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'A mockumentary on a group of typical office workers, where the workday consists of ego clashes, inappropriate behavior, and tedium.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: <Widget>[
                            Text(
                              'Episodes',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '19',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: Color(AppColors.lightGrey())),
                            ),
                          ],
                        ),
                        for (int i = 0; i < 10; i++)
                          EpisodeTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const EpisodeDetailsPage()));
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const AddEpisodePage(),
            fullscreenDialog: true,
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'Add episode',
      ),
    );
  }
}
