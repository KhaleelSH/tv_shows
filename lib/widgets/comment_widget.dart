import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tv_shows/models/comment.dart';
import 'package:tv_shows/utils/app_colors.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Shows random profile image from a set of 3 images.
        Image.asset('assets/images/image_placeholder_user'
            '_${math.Random().nextInt(3) + 1}.png'),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.username,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const Spacer(),
                  // There is no time value coming back from the server.
                  Text(
                    '5min',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(AppColors.lightGrey()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                comment.comment,
                style: TextStyle(
                  color: Color(AppColors.darkGrey()),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
