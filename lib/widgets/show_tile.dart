import 'package:flutter/material.dart';

class ShowTile extends StatelessWidget {
  const ShowTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Placeholder(
          fallbackWidth: 64,
          fallbackHeight: 90,
        ),
        SizedBox(width: 16),
        Text(
          'The Hitman\'s Bodyguard',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF505050),
          ),
        ),
      ],
    );
  }
}
