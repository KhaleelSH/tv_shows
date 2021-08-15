import 'dart:io';

import 'package:flutter/material.dart';

/// [BackButtonAppBar] is an AppBar that only contains a back button.
class BackButtonAppBar extends StatelessWidget {
  const BackButtonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.keyboard_arrow_left,
          ),
        ),
      ),
    );
  }
}
