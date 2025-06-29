import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/newsdetail.dart';

class InternationalNewsPage extends StatefulWidget {
  const InternationalNewsPage({super.key});

  @override
  State<InternationalNewsPage> createState() => _InternationalNewsPageState();
}

class _InternationalNewsPageState extends State<InternationalNewsPage> {
    final String apiKey = '66e677985eff4fe0810c93493f7f5bd0';
  List<dynamic> internationalNews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInternationalNews();
  }

  // Future<void> fetchInternationalNews() async {
  //   try {
  //     final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'));
  //     if (response.statusCode == 200) {
  //       final jsonString = utf8.decode(response.bodyBytes);
  //       final data = json.decode(jsonString);

  //       List<dynamic> articles = [];
  //       if (data is List) {
  //         articles = data;
  //       } else if (data is Map<String, dynamic>) {
  //         if (data.containsKey('articles')) {
  //           articles = data['articles'];
  //         } else if (data.containsKey('data')) {
  //           articles = data['data'];
  //         } else {
  //           articles = data.values.expand((value) => value is List ? value : []).toList();
  //         }
  //       }

  //       print("Fetched Articles: ${articles.length}");

  //       // Enhanced filtering logic
  //       final filtered = articles.where((article) {
  //         final content = ((article['title'] ?? '') + (article['description'] ?? '')).toLowerCase();
  //         return content.contains('international') ||
  //                content.contains('global') ||
  //                content.contains('foreign') ||
  //                content.contains('world') ||
  //                content.contains('united nations') ||
  //                content.contains('overseas');
  //       }).toList();

  //       print("Filtered Articles: ${filtered.length}");

  //       setState(() {
  //         internationalNews = filtered;
  //         isLoading = false;
  //       });
  //     } else {
  //       throw Exception('Failed to load news');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: ${e.toString()}')),
  //     );
  //   }
  // }
  Future<void> fetchInternationalNews() async {
  try {
    final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=international&language=en&sortBy=publishedAt&apiKey=$apiKey'
    ));

    if (response.statusCode == 200) {
      final jsonString = utf8.decode(response.bodyBytes);
      final data = json.decode(jsonString);
      final List<dynamic> articles = data['articles'];

      setState(() {
        internationalNews = articles;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load international news');
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("International News")),
      body:  isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: internationalNews.length,
                    itemBuilder: (context, index) {
                      final article = internationalNews[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        NewsDetailPage(article: article),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                   image: NetworkImage(article["urlToImage"] ?? ''),

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article['category'] ?? 'General',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    article['title'] ?? 'No title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          
    );
  }
}