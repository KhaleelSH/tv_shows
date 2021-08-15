import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/utils/app_colors.dart';

const int _kDefaultSeasons = 30;
const int _kDefaultEpisodes = 99;

class SeasonAndEpisodePicker extends StatefulWidget {
  const SeasonAndEpisodePicker({
    Key? key,
    required this.onChangeSeason,
    required this.onChangeEpisode,
  }) : super(key: key);

  // [ValueChanged] allows us to pass a callback with one argument.
  final ValueChanged<int> onChangeSeason;
  final ValueChanged<int> onChangeEpisode;

  @override
  _SeasonAndEpisodePickerState createState() => _SeasonAndEpisodePickerState();
}

class _SeasonAndEpisodePickerState extends State<SeasonAndEpisodePicker> {
  int _season = 1;
  int _episode = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      .copyWith(color: Color(AppColors.lightGrey())),
                ),
                Text(
                  'S$_season E$_episode',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).primaryColor),
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
    );
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
                    widget.onChangeSeason(i + 1);
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
                    widget.onChangeEpisode(i + 1);
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
