import 'dart:convert';

import 'package:api/Models/photos_model.dart';
import 'package:api/Models/user_model.dart';
import 'package:api/photo_no_model.dart';
import 'package:api/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosScreen extends StatefulWidget {
  static const String id = 'photos_screen';
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<PhotosModel> photoList = [];

  Future<List<PhotosModel>> getPostApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      photoList = [];
      // for (Map i in data) {
      //   photoList.add(PhotosModel.fromJson(i as Map<String, dynamic>));
      // }
      photoList.addAll(List<PhotosModel>.from(
          jsonDecode(response.body.toString())
              .map((x) => PhotosModel.fromJson(x))));

      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Photos')),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('No data found !');
              } else {
                return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    // return Text(photoList[index].title.toString());
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, UserScreen.id);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            photoList[index].thumbnailUrl.toString(),
                          ),
                        ),
                        title: Text(
                          photoList[index].title.toString(),
                          style: TextStyle(
                              fontWeight: index % 2 == 0
                                  ? FontWeight.bold
                                  : FontWeight.w900),
                        ),
                        subtitle: Text(
                          photoList[index].url.toString(),
                          style: const TextStyle(
                              decoration: TextDecoration.underline),
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
