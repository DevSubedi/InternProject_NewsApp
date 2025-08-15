class NewsModel {
  final String? author;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? publishedAt;
  final String? content;

  const NewsModel({
    this.author,
    this.title,
    this.description,
    this.imageUrl,
    this.publishedAt,
    this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['urlToImage'], // map to correct key
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': imageUrl,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  static const emptyNewsModel = NewsModel(
    author: '',
    title: '',
    description: '',
    imageUrl: '',
    publishedAt: '',
    content: '',
  );
}
