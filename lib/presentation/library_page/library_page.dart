import 'package:audiobook_player/presentation/widgets/music_tile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class LibraryPage extends StatefulWidget {
  final bool isPlay;
  final List<PlatformFile> paths;
  final AudioPlayer player01;
  // final List<String> listOfFileName;

  LibraryPage({Key key, this.paths, this.isPlay, this.player01})
      : super(key: key);
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Open Audiobook"),
          actions: <Widget>[
            InkWell(
              onTap: () async {},
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.add_circle_outline_rounded),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: widget.paths.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                var duration =
                    await widget.player01.setFilePath(widget.paths[index].path);
                widget.player01.play();
                isPlay = true;
              },
              child: MusicTile(
                  musicName: widget.paths[index].name,
                  authorName: "authorName"),
            );
          },
        ));
  }
}
