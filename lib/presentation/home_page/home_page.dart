import 'package:audiobook_player/presentation/library_page/library_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _fileName;
  List<PlatformFile> _paths = [];
  List<String> _listOfFileName = <String>[];
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = true;
  List<String> _listOfPaths;
  FileType _pickingType = FileType.audio;
  bool isPlay = false;
  final player = AudioPlayer();

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
      _listOfFileName.add(_fileName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Open Audiobook Player",
          style: TextStyle(color: Color(0xFF747474)),
        ),
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_outlined,
          color: Color(0xFF757575),
        ),
        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.local_library_rounded,
              color: Color(0xFF757575),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LibraryPage(
                    paths: _paths,
                    player01: player,
                  ),
                ),
              );
            },
          ),
          InkWell(
            focusColor: Color(0xFF757575),
            onTap: () async {
              setState(() async {
                await _openFileExplorer();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LibraryPage(
                      //listOfFileName: _listOfFileName,
                      paths: _paths,
                      isPlay: false,
                    ),
                  ),
                );
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.add_circle_outline_rounded,
                  color: Color(0xFF757575)),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(width: size.width * 0.05),
              Expanded(
                  child: IconButton(
                      icon: Icon(Icons.alarm_on_rounded), onPressed: () {})),
              //SizedBox(width: size.width * 0.5),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () {},
                ),
              ),
              Expanded(
                  child: IconButton(
                icon: Icon(Icons.equalizer_rounded),
                onPressed: () {},
              )),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.lock_open),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: size.width * 0.22,
                        icon: Icon(
                          Icons.skip_previous_outlined,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: IconButton(
                          iconSize: size.width * 0.22,
                          icon: isPlay
                              ? Icon(Icons.pause_sharp)
                              : Icon(Icons.play_arrow_sharp),
                          onPressed: () async {
                            setState(() {
                              if (isPlay == true) {
                                player.pause();
                                isPlay = false;
                              } else {
                                player.play();
                                isPlay = true;
                              }
                            });
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: size.width * 0.22,
                        icon: Icon(Icons.skip_next_outlined),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
