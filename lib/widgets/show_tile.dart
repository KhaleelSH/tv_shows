import 'package:flutter/material.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/utils/app_colors.dart';

class ShowTile extends StatelessWidget {
  const ShowTile({
    Key? key,
    required this.onTap,
    required this.show,
  }) : super(key: key);

  final Show show;
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
              color: Color(AppColors.mystic()),
              border: Border.all(
                color: Color(AppColors.mystic()),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Hero(
                tag: 'show_image_${show.title}',
                child: Image.network(
                  show.imageUrl,
                  width: 64,
                  height: 90,
                  fit: BoxFit.cover,
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
          ),
          const SizedBox(width: 16),
          Text(
            show.title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
