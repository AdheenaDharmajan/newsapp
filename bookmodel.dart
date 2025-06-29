import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkStorage {
  static const String _key = 'bookmarked_articles';

  static Future<void> addBookmark(Map<String, dynamic> article) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    if (!bookmarks.any((a) => a['url'] == article['url'])) {
      bookmarks.add(article);
      await prefs.setString(_key, json.encode(bookmarks));
    }
  }

  static Future<List<Map<String, dynamic>>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return List<Map<String, dynamic>>.from(jsonList);
  }
}