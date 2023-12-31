import 'dart:convert';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<Blog>> fetchBlogs() async {
    try {
      Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        return jsonData.map((json) => Blog.fromJson(json)).toList();
      } else {
        throw Exception('HTTP request failed');
      }
    } catch (e) {
      throw Exception('Failed to fetch blogs');
    }
  }
}
