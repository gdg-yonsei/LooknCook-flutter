import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/cook_tutorial.dart';
import 'package:lookncook/dtos/ingredient.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItem extends StatelessWidget {
  final CookTutorial video;

  const VideoItem({super.key, required this.video});

  void openBrowser() async {
    Uri uri = Uri.parse(video.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${video.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(video.thumbnail,
          width: 80, height: 40, fit: BoxFit.cover),
      title: Text(
        video.title,
      ),
      subtitle: Text(video.description),
      onTap: openBrowser,
    );
  }
}
