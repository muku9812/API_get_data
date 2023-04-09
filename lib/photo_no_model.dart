import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoSrc extends StatefulWidget {
  static const String id = 'photos_src';
  const PhotoSrc({super.key});

  @override
  State<PhotoSrc> createState() => _PhotoSrcState();
}

class _PhotoSrcState extends State<PhotoSrc> {
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Call of photos'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getPhotos(),
                  builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                    return ListView.builder(itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].url.toString())),
                          title: Text(snapshot.data![index].title.toString()),
                          subtitle: Text('Note Id :-' +
                              snapshot.data![index].id.toString()),
                        );
                      } else {
                        return Text('No data Available !');
                      }
                    });
                  }))
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
