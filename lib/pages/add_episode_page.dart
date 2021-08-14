import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;

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
        middle: Text(
          'Add Episode',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
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
            if (_image == null)
              GestureDetector(
                onTap: _showCameraOrPhotoLibrarySourcePicker,
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
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Image.file(
                _image!,
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showSeasonAndEpisodePicker,
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

  void _showCameraOrPhotoLibrarySourcePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _pickImageFromSource(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                title: const Text('Camera'),
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  _pickImageFromSource(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                title: const Text('Photo Library'),
                leading: Icon(
                  Icons.image,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageFromSource(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _showSeasonAndEpisodePicker() {
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
