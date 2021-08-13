import 'package:flutter/material.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: onTap,
      title: Row(
        children: [
          Text(
            'S02 E06',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Episode Title',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}
