import 'package:flutter/material.dart';

class ShowTile extends StatelessWidget {
  const ShowTile({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEEF1F5),
              border: Border.all(
                color: const Color(0xFFEEF1F5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://i.ytimg.com/vi/MJuFdpVCcsY/movieposter_en.jpg',
                width: 64,
                height: 90,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/image_placeholder_episodes.png',
                    height: 90,
                    width: 64,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'The Hitman\'s Bodyguard',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
