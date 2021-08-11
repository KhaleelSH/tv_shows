import 'package:flutter/material.dart';
import 'package:tv_shows/widgets/show_tile.dart';

class ShowsPage extends StatelessWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        primary: true,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'Shows',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, i) {
          return const ShowTile();
        },
        separatorBuilder: (context, i) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
