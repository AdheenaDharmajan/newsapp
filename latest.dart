import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/newsdetail.dart';
import 'dart:convert';

class LatestNewsPage extends StatefulWidget {
  const LatestNewsPage({super.key});

  @override
  State<LatestNewsPage> createState() => _LatestNewsPageState();
}

class _LatestNewsPageState extends State<LatestNewsPage> {
  List<dynamic> newsList = [];
   final String apiKey = '66e677985eff4fe0810c93493f7f5bd0';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLatestNews();
  }

  Future<void> fetchLatestNews() async {
    try {
      final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> articles = [];

        if (data is List) {
          articles = data;
        } else if (data is Map<String, dynamic>) {
          if (data.containsKey('articles')) {
            articles = data['articles'];
          } else if (data.containsKey('data')) {
            articles = data['data'];
          } else {
            throw Exception('No recognizable list of articles in response');
          }
        }

        setState(() {
          newsList = articles;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Latest News")),
      body: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final article = newsList[index];
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
                                        article["image"] ?? article["urlToImage"] ?? ''),
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