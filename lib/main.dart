import 'package:api/comments_screen.dart';
import 'package:api/home_screen.dart';
import 'package:api/photo_no_model.dart';
import 'package:api/photos_screen.dart';
import 'package:api/users_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        // ignore: prefer_const_constructors
        CommentScreen.id: (context) => CommentScreen(),
        PhotosScreen.id: (context) => PhotosScreen(),
        PhotoSrc.id: (context) => PhotoSrc(),
        UserScreen.id: (context) => UserScreen(),
      },
    );
  }
}
