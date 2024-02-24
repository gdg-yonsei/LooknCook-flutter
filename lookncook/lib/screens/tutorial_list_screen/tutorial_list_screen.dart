import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lookncook/apis/apis.dart';
import 'package:lookncook/components/loading_indicator.dart';
import 'package:lookncook/dtos/cook_tutorial.dart';
import 'package:lookncook/screens/%08tutorial_list_screen/components/video_item.dart';
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
  bool isLoading = true;
  late List<CookTutorialCategory> categories;

  late CookTutorialCategory selectedCategory;

  @override
  void initState() {
    super.initState();
    _searchVideos();
  }

  void _searchVideos() async {
    var res = await LCApis().getTutorials();
    // res.forEach((element) {
    //   Logger().logInfo(element.toString());
    // });

    Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;

        categories = res;
        selectedCategory = res[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("????");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cooking Tutorials For You'),
        ),
        body: isLoading
            ? const LoadingIndicator()
            : Column(
                children: [
                  // Category selector chips
                  Wrap(
                      children: categories
                          .map((category) => Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: ChoiceChip(
                                  label: Text(
                                    category.category,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  selected: selectedCategory.category ==
                                      category.category,
                                  onSelected: (value) => setState(
                                      () => selectedCategory = category),
                                ),
                              ))
                          .toList()),

                  // Filtered video list
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: selectedCategory.videos.map((video) {
                          return VideoItem(video: video);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
