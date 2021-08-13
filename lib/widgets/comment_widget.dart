import 'package:flutter/material.dart';
import 'package:tv_shows/utils/app_colors.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/image_placeholder_user_1.png'),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Andrei',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const Spacer(),
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
                'Well, this episode really sucks. Such a time wasting. Well, this episode really sucks. Such a time wasting.',
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
