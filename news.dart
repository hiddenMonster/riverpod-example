class News {
  final String by;
  final int descendants;
  final int id;
  final List<int> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  News({
    required this.by,
    required this.descendants,
    required this.id,
    required this.kids,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
    required this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      by: json['by'],
      descendants: json['descendants'],
      id: json['id'],
      kids: json['kids'].cast<int>(),
      score: json['score'],
      time: json['time'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['by'] = by;
    data['descendants'] = descendants;
    data['id'] = id;
    data['kids'] = kids;
    data['score'] = score;
    data['time'] = time;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
