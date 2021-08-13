import 'package:flutter/material.dart';
import 'package:tv_shows/utils/app_colors.dart';
import 'package:tv_shows/widgets/comment_widget.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const noComments = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          noComments
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                          'assets/images/image_placeholder_comments.png'),
                      const Text(
                        'Sorry, we don’t have comments yet.\nBe first who will write a review.',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.5),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        for (int i = 0; i < 2; i++) ...[
                          const CommentWidget(),
                          const Divider(),
                        ],
                        const CommentWidget(),
                      ],
                    ),
                  ),
                ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color(AppColors.lighterGrey()), width: 2)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(AppColors.lighterGrey()),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _commentController,
                      focusNode: _commentNode,
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (String value) {
                        _commentController.clear();
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        isDense: true,
                        hintText: 'Add a comment...',
                        hintStyle:
                            Theme.of(context).textTheme.caption!.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                        suffix: GestureDetector(
                          child: Text(
                            'Post',
                            style: Theme.of(context).textTheme.button!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          onTap: () {
                            _commentController.clear();
                            _commentNode.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
