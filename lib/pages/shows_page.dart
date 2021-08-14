import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/pages/login_page.dart';
import 'package:tv_shows/pages/show_details_page.dart';
import 'package:tv_shows/state/auth_provider.dart';
import 'package:tv_shows/state/shows_provider.dart';
import 'package:tv_shows/widgets/show_tile.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  _ShowsPageState createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ShowsProvider>(context, listen: false).getShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Shows',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Consumer<ShowsProvider>(
        builder: (context, provider, child) {
          if (provider.loadingShows) {
            return _loadingShowsWidget();
          }
          if (provider.shows.isEmpty) {
            return _noShowsFoundWidget();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.shows.length,
            itemBuilder: (context, index) {
              return ShowTile(
                show: provider.shows[index],
                onTap: () async {
                  provider.setCurrentSelectedShow(provider.shows[index]);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ShowDetailsPage()));
                },
              );
            },
            separatorBuilder: (context, i) {
              return const SizedBox(height: 8);
            },
          );
        },
      ),
    );
  }

  Widget _loadingShowsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/image_placeholder_registration.png'),
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _noShowsFoundWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/image_placeholder_episodes.png'),
          const SizedBox(height: 16),
          const Text(
            'Sorry, we don’t have shows yet.',
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}
