import 'package:flutter/material.dart';
import 'package:tv_shows/pages/login_page.dart';
import 'package:tv_shows/widgets/show_tile.dart';

class ShowsPage extends StatelessWidget {
  const ShowsPage({Key? key}) : super(key: key);

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
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, i) {
          return ShowTile(
            onTap: () {},
          );
        },
        separatorBuilder: (context, i) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
