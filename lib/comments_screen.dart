import 'dart:convert';

import 'package:api/Models/comment_model.dart';
import 'package:api/photo_no_model.dart';
import 'package:api/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentScreen extends StatefulWidget {
  static const String id = 'comments_screen';
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<CommentsModel> commentList = [];

  // get http => null;

  Future<List<CommentsModel>> getPostApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      commentList.clear();
      for (Map i in data) {
        commentList.add(CommentsModel.fromJson(i as Map<String, dynamic>));
      }
      return commentList;
    } else {
      return commentList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Comments')),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                return ListView.builder(
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PhotosScreen.id);
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: const Text(
                                'Gmail:- ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Text(
                              commentList[index].email.toString(),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              'Name:- ',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              commentList[index].name.toString(),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              'Description:- ',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                            Center(
                                child:
                                    Text(commentList[index].body.toString())),
                            const SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
