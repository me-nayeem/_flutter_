import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/article_model.dart';

class NewsService {
  static String get _apiKey => dotenv.env['NEWS_API_KEY'] ?? '';

  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<ArticleModel>> fetchTopHeadlines() async {
    final url = Uri.parse(
      '$_baseUrl?country=us&apiKey=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      final List<dynamic> articlesJson = data['articles'];
      return articlesJson
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
    } else {
      throw Exception('Failed to load news articles');
    }
  }
}