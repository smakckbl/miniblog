import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/widgets/blog_detail.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(blogId: blog.id!),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 15 / 15,
                child: Container(
                  color: const Color.fromARGB(255, 208, 228, 244),
                  width: double.infinity,
                  child: Image.network(blog.thumbnail!),
                ),
              ),
              ListTile(
                title: Text(blog.title!),
                subtitle: Text(blog.author!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}