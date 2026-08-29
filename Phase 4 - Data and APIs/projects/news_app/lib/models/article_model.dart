class ArticleModel {
  final String title;
  final String description;
  final String url;
  final String imageUrl;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description available',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
    );
  }
}