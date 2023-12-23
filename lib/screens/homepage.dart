import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogList = [];

  @override
  void initState() {
    super.initState();
    // http paketi ile istek
    fetchBlogs();
  }

  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);
    setState(() {
      blogList = jsonData.map((json) => Blog.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FLUTTER BLOG"),
        actions: [
          IconButton(
            onPressed: () async {
              bool? result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => AddBlog(),
                ),
              );

              if (result == true) {
                fetchBlogs();
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: blogList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                fetchBlogs();
              },
              child: ListView.builder(
                itemBuilder: (ctx, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 19, horizontal: 40),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 7,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: BlogItem(blog: blogList[index]),
                ),
                itemCount: blogList.length,
              ),
            ),
    );
  }
}
