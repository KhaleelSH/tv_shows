import 'package:flutter/material.dart';
import 'package:tv_shows/models/episode.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({
    Key? key,
    required this.episode,
    required this.onTap,
  }) : super(key: key);

  final Episode episode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: onTap,
      title: Row(
        children: [
          Text(
            'S${episode.seasonNumber.padLeft(2, '0')} E${episode.episodeNumber.padLeft(2, '0')}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              (episode.title?.isEmpty ?? true) ? 'No Title' : episode.title!,
              style: const TextStyle(fontSize: 16),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}
