import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/utils/app_colors.dart';

const int _kDefaultSeasons = 30;
const int _kDefaultEpisodes = 99;

class AddEpisodePage extends StatefulWidget {
  const AddEpisodePage({Key? key}) : super(key: key);

  @override
  _AddEpisodePageState createState() => _AddEpisodePageState();
}

class _AddEpisodePageState extends State<AddEpisodePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  int _season = 1;
  int _episode = 1;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        middle: const Text(
          'Add Episode',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Add',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        border: Border.all(color: Colors.transparent),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Upload Photo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showSeasonAndEpisodePicker(context);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Season & Episode',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Color(AppColors.lightGrey())),
                              ),
                              Text(
                                'S$_season E$_episode',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            thickness: 1,
                            color: Color(AppColors.lightGrey()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    focusNode: _titleNode,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Episode Title',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    focusNode: _descriptionNode,
                    decoration: const InputDecoration(
                      labelText: 'Episode Description',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSeasonAndEpisodePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: Row(
            children: <Widget>[
              Expanded(
                child: CupertinoPicker(
                  scrollController:
                      FixedExtentScrollController(initialItem: _season - 1),
                  itemExtent: 32,
                  backgroundColor: Colors.white,
                  onSelectedItemChanged: (int i) {
                    setState(() => _season = i + 1);
                  },
                  children: List<Widget>.generate(
                    _kDefaultSeasons,
                    (int i) {
                      return Center(
                        child: Text('S${(i + 1).toString().padLeft(2, '0')}'),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController:
                      FixedExtentScrollController(initialItem: _episode - 1),
                  itemExtent: 32,
                  backgroundColor: Colors.white,
                  onSelectedItemChanged: (int i) {
                    setState(() => _episode = i + 1);
                  },
                  children: List<Widget>.generate(
                    _kDefaultEpisodes,
                    (int i) {
                      return Center(
                        child: Text('E${(i + 1).toString().padLeft(2, '0')}'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
