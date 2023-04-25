// ignore_for_file: prefer_const_constructors

import 'dart:convert';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_app/movie_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MovieItem> movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Fancy Movies"),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white.withAlpha(100),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    movies[position].poster,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 60,
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      movies[position].year,
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red.withAlpha(50),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        movies[position].type.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  movies[position].title,
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(
                height: 10,
              );
            },
            itemCount: movies.length));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    final dio = Dio();
    String url = "http://www.omdbapi.com/?apikey=1bd9bfbf&s=Batman&page=2";
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      // List<String, int> sample = ["33", 5];
      var encoded = jsonEncode(response.data);
      Map<String, dynamic> result = jsonDecode(
        encoded,
      );

      var searchResult = result["Search"];
      for (var movie in searchResult) {
        String title = movie["Title"];
        String year = movie["Year"];
        String type = movie["Type"];
        String poster = movie["Poster"];

        MovieItem movieItem =
            MovieItem(poster: poster, title: title, type: type, year: year);

        movies.add(movieItem);
      }
      setState(() {});
    }
  }
}
