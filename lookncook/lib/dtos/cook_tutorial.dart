class CookTutorial {
  final String title;
  final String description;
  final String thumbnail;
  final String url;

  CookTutorial(
      {required this.title,
      required this.description,
      required this.thumbnail,
      required this.url});

  @override
  String toString() {
    // TODO: implement toString
    return "[title] $title / [description] $description / url $url";
  }
}

class CookTutorialCategory {
  final String category;
  final List<CookTutorial> videos;

  CookTutorialCategory({
    required this.category,
    required this.videos,
  });

  @override
  String toString() {
    return ["[category] $category", ...videos.map((e) => "\t$e").toList()]
        .join("\n");
  }
}
