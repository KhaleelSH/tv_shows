import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/pages/add_episode_page.dart';
import 'package:tv_shows/pages/episode_details_page.dart';
import 'package:tv_shows/state/shows_provider.dart';
import 'package:tv_shows/utils/app_colors.dart';
import 'package:tv_shows/widgets/adaptive_refresh_indicator.dart';
import 'package:tv_shows/widgets/back_button_app_bar.dart';
import 'package:tv_shows/widgets/episode_tile.dart';

class ShowDetailsPage extends StatefulWidget {
  const ShowDetailsPage({Key? key}) : super(key: key);

  @override
  _ShowDetailsPageState createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  late ShowsProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      provider = Provider.of<ShowsProvider>(context, listen: false);
      provider.getShowDescription();
      provider.getShowEpisodes();
    });
  }

  @override
  void dispose() {
    provider.clearCurrentSelectedShow();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AdaptiveRefreshIndicator(
            onRefresh: () async {
              await Future.wait([
                Provider.of<ShowsProvider>(context, listen: false)
                    .getShowDescription(showLoading: false),
                Provider.of<ShowsProvider>(context, listen: false)
                    .getShowEpisodes(showLoading: false),
              ]);
            },
            child: SingleChildScrollView(
              child: Consumer<ShowsProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag:
                            'show_image_${provider.currentSelectedShow!.title}',
                        child: Stack(
                          children: [
                            Image.network(
                              provider.currentSelectedShow!.imageUrl,
                              height: MediaQuery.of(context).size.height / 2,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/image_placeholder_episodes.png',
                                  height:
                                      MediaQuery.of(context).size.height / 2,
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
                      Consumer<ShowsProvider>(
                        builder: (context, provider, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  provider.currentSelectedShow!.title,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                const SizedBox(height: 16),
                                if (provider
                                    .loadingCurrentSelectedShowDescription)
                                  const Center(
                                      child: CircularProgressIndicator())
                                else
                                  Text(
                                    provider.currentSelectedShowDescription ??
                                        'No description',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                const SizedBox(height: 32),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Episodes',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    const SizedBox(width: 8),
                                    if (!provider
                                        .loadingCurrentSelectedShowEpisodes)
                                      Text(
                                        provider
                                            .currentSelectedShowEpisodes.length
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                color: Color(
                                                    AppColors.lightGrey())),
                                      ),
                                  ],
                                ),
                                if (provider.loadingCurrentSelectedShowEpisodes)
                                  const Center(
                                      child: CircularProgressIndicator())
                                else if (provider
                                    .currentSelectedShowEpisodes.isEmpty)
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            'assets/images/image_placeholder_episodes.png'),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Sorry, we don’t have episodes yet.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(height: 1.5),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  for (final episode
                                      in provider.currentSelectedShowEpisodes)
                                    EpisodeTile(
                                      episode: episode,
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    EpisodeDetailsPage(
                                                        episode: episode)));
                                      },
                                    ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
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
