import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/state/shows_provider.dart';
import 'package:tv_shows/widgets/season_episode_picker.dart';

class AddEpisodePage extends StatefulWidget {
  const AddEpisodePage({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  @override
  _AddEpisodePageState createState() => _AddEpisodePageState();
}

class _AddEpisodePageState extends State<AddEpisodePage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  int _season = 1;
  int _episode = 1;
  File? _image;
  bool _addingNewEpisode = false;

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
        trailing: _addingNewEpisode
            ? const CircularProgressIndicator.adaptive()
            : GestureDetector(
                onTap: addNewEpisode,
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
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    SeasonAndEpisodePicker(
                      onChangeEpisode: (episode) {
                        setState(() => _episode = episode);
                      },
                      onChangeSeason: (int season) {
                        setState(() => _season = season);
                      },
                    ),
                    TextFormField(
                      controller: _titleController,
                      focusNode: _titleNode,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Episode Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter episode title';
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      focusNode: _descriptionNode,
                      decoration: const InputDecoration(
                        labelText: 'Episode Description',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter episode descriptin';
                        }
                      },
                    ),
                  ],
                ),
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

  Future<void> addNewEpisode() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please pick an image before adding a new episode')));
      return;
    }
    if (!_form.currentState!.validate()) {
      return;
    }
    try {
      setState(() => _addingNewEpisode = true);
      final imageId = await Provider.of<ShowsProvider>(context, listen: false)
          .uploadImage(filePath: _image!.path);
      await Provider.of<ShowsProvider>(context, listen: false).addNewEpisode(
        showId: widget.show.id,
        mediaId: imageId,
        title: _titleController.text,
        description: _descriptionController.text,
        seasonNumber: _season.toString(),
        episodeNumber: _episode.toString(),
      );
      Provider.of<ShowsProvider>(context, listen: false)
          .getShowEpisodes(showLoading: false);
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _addingNewEpisode = false);
    }
  }
}
