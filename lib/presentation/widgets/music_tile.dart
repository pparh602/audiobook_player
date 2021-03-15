import 'package:flutter/material.dart';

class MusicTile extends StatelessWidget {
  final String musicName;
  final String authorName;

  const MusicTile(
      {Key key, @required this.musicName, @required this.authorName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/audiobook_image.jpg"),
                    fit: BoxFit.scaleDown),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListTile(
                title: Text(
                  musicName,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(authorName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
