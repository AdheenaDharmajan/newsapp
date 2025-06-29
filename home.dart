import 'package:flutter/material.dart';
import 'package:newsapp/bookmarks.dart';
import 'package:newsapp/newsdetail.dart';
import 'package:newsapp/service.dart';
import 'package:newsapp/entertainmentnews.dart';
import 'package:newsapp/internationalnews.dart';
import 'package:newsapp/latest.dart';
import 'package:newsapp/profile.dart';
import 'package:newsapp/sportsnews.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
List<dynamic> _filteredNewsList = [];

  final newsService = NewsService();
  List<dynamic> _newsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {
  try {
    final news = await newsService.fetchTrendingNews();
    setState(() {
      _newsList = news;
      _filteredNewsList = news; // initialize with full list
      _isLoading = false;
    });
  } catch (e) {
    print('❌ Error fetching news: $e');
    setState(() {
      _isLoading = false;
    });
  }
}
void _filterNews(String query) {
  final filtered = _newsList.where((article) {
    final title = (article['title'] ?? '').toLowerCase();
    final lowerQuery = query.toLowerCase();
    return title.contains(lowerQuery);
  }).toList();

  setState(() {
    _filteredNewsList = filtered;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News Live',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(232, 255, 72, 0),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 16, height: 2, color: Colors.white),
                      const SizedBox(height: 6),
                      Container(width: 11, height: 2, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Myprofile()));
              },
             child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child:
                          const Icon(Icons.person, size: 27, color: Colors.black),
                    ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(232, 255, 72, 0),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(232, 255, 72, 0),
              ),
              child: Text(
                'News Live',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem('Latest', const LatestNewsPage()),
            _buildDrawerItem('International', const InternationalNewsPage()),
            _buildDrawerItem('Entertainment', const EntertainmentNewsPage()),
            _buildDrawerItem('Sports', const SportsNewsPage()),
            _buildDrawerItem('Bookmarks', const BookmarkPage()),
            _buildDrawerItem('My Profile', const Myprofile()),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
               controller: _searchController,
               onChanged: _filterNews, // filter as user types
              decoration: InputDecoration(
                hintText: 'Search for articles...',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 16),
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Latest News",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
         Expanded(
  child: _isLoading
      ? const Center(child: CircularProgressIndicator())
      : _filteredNewsList.isEmpty
          ? const Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _filteredNewsList.length,
              itemBuilder: (context, index) {
                final article = _filteredNewsList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NewsDetailPage(article: article),
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
                                article["image"] ?? article["urlToImage"] ?? '',
                              ),
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
                                color: Colors.grey,
                                fontSize: 12,
                              ),
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
),

        ],
      ),
    );
  }

  ListTile _buildDrawerItem(String title, Widget destination) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => destination));
      },
    );
  }
}