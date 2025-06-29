import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/newsdetail.dart';
import 'dart:convert';

class EntertainmentNewsPage extends StatefulWidget {
  const EntertainmentNewsPage({super.key});

  @override
  State<EntertainmentNewsPage> createState() => _EntertainmentNewsPageState();
}

class _EntertainmentNewsPageState extends State<EntertainmentNewsPage> {
    final String apiKey = '66e677985eff4fe0810c93493f7f5bd0';
  List<dynamic> entertainmentNews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEntertainmentNews();
  }

  Future<void> fetchEntertainmentNews() async {
    try {
      final response = await http.get(
  Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=$apiKey'),
);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));

        List<dynamic> articles = [];
        if (data is List) {
          articles = data;
        } else if (data is Map<String, dynamic>) {
          if (data.containsKey('articles')) {
            articles = data['articles'];
          } else if (data.containsKey('data')) {
            articles = data['data'];
          }
        }

        // Filter only entertainment-related articles
        final filtered = articles.where((article) {
          final title = (article['title'] ?? '').toString().toLowerCase();
          final description = (article['description'] ?? '').toString().toLowerCase();
          return title.contains('entertain') || description.contains('entertain') ||
                 title.contains('movie') || description.contains('movie') ||
                 title.contains('film') || description.contains('film') ||
                 title.contains('celebrity') || description.contains('celebrity') ||
                 title.contains('bollywood') || description.contains('bollywood') ||
                 title.contains('hollywood') || description.contains('hollywood') ||
                 title.contains('tv') || description.contains('tv') ||
                 title.contains('series') || description.contains('series');
        }).toList();

        setState(() {
          entertainmentNews = filtered;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load entertainment news');
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
    appBar: AppBar(title: const Text("Entertainment News")),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : entertainmentNews.isEmpty
            ? const Center(
                child: Text(
                  'No entertainment news found.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: entertainmentNews.length,
                itemBuilder: (context, index) {
                  final article = entertainmentNews[index];
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
                                image: NetworkImage(
                                    article["image"] ??
                                    article["urlToImage"] ??
                                    ''),
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
