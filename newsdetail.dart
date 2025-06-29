import 'package:flutter/material.dart';
import 'package:newsapp/bookmodel.dart';
import 'package:newsapp/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['title'] ?? 'News Detail')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article['urlToImage'] != null)
                    Image.network(article['urlToImage']),
                  const SizedBox(height: 16),
                  Text(
                    article['title'] ?? '',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(article['description'] ?? 'No description'),
                  const SizedBox(height: 12),
                  Text(article['content'] ?? 'No content available'),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () async {
                      final uri = Uri.parse(article['url']);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    child: const Text("Read Full Article",
                    style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'bookmark',
                  onPressed: () async {
                    await BookmarkStorage.addBookmark(article);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bookmarked')),
                    );
                  },
                  child: const Icon(Icons.bookmark,color: Color.fromARGB(232, 255, 72, 0),),
                  mini: true,
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'share',
                  onPressed: () {
                    final url = article['url'] ?? '';
                    final title = article['title'] ?? '';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SharePage(title: title, url: url),
                      ),
                    );
                  },
                  child: const Icon(Icons.share,color: Color.fromARGB(232, 255, 72, 0),),
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}