import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String by;
  final int descendants;
  final int id;
  final List<int> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  News(
      {this.by,
      this.descendants,
      this.id,
      this.kids,
      this.score,
      this.time,
      this.title,
      this.type,
      this.url});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    data['kids'] = this.kids;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }

  @override
  List<Object> get props => [
        this.by,
        this.descendants,
        this.id,
        this.kids,
        this.score,
        this.time,
        this.title,
        this.type,
        this.url
      ];
}
