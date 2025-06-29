import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '66e677985eff4fe0810c93493f7f5bd0'; // ✅ Your API Key

  // Fetch trending news from NewsAPI
  Future<List<dynamic>> fetchTrendingNews() async {
    final String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load trending news');
    }
  }

  // ✅ Fetch news from qualcastbeta.in
//   Future<List<dynamic>> fetchNewsFromQualcast() async {
//     final String url = 'https://qualcastbeta.in/news.json';

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data is List) {
//         return data;
//       } else if (data['articles'] != null) {
//         return data['articles'];
//       } else {
//         throw Exception('Unexpected data format from Qualcast');
//       }
//     } else {
//       throw Exception('Failed to load news from Qualcast');
//     }
//   }
}