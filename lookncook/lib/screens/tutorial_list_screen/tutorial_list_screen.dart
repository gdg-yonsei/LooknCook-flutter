import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lookncook/apis/apis.dart';
import 'package:lookncook/utils/Logger.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(TutorialListScreen());
}

class TutorialListScreen extends StatefulWidget {
  @override
  _TutorialListScreenState createState() => _TutorialListScreenState();
}

class _TutorialListScreenState extends State<TutorialListScreen> {
  final List<String> videoIds = [];
  final List<String> categories = [
    "Main Course",
    "Dessert",
    "Technique" // Add more categories as needed
  ];
  String selectedCategory = "All";

  final loading = true;

  @override
  void initState() {
    super.initState();
    _searchVideos();
  }

  void _searchVideos() async {
    var res = await LCApis().getTutorials();
    res.forEach((element) {
      Logger().logInfo(element.toString());
    });

    // setState(() {});
  }

  void openBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Blind Cooking Tips'),
        ),
        body: Column(
          children: [
            // Category selector chips
            Wrap(
              children: categories
                  .map((category) => ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (value) =>
                            setState(() => selectedCategory = category),
                      ))
                  .toList(),
            ),
            // Filtered video list
            Expanded(
              child: ListView.builder(
                itemCount: videoIds.length,
                itemBuilder: (context, index) {
                  if (selectedCategory == "All" ||
                      categories[index] == selectedCategory) {
                    return ListTile(
                      title: Text(videoIds[index].split('/').last),
                      onTap: () => openBrowser(videoIds[index]),
                    );
                  } else {
                    return SizedBox(); // Hide unselected category videos
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
