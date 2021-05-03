import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_middle/movie/results.dart';
import 'package:http/http.dart' as http;
import 'movie_result.dart';

class MovieProvider extends ChangeNotifier {
  List<Results> _movies = [];
  final List<Results> _filteredItems = [];



  Future<MovieResult> fetchData() async {
    var uri = Uri.parse(
        'http://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1');
    var response = await http.get(uri);

    MovieResult result = MovieResult.fromJson(json.decode(response.body));

    return result;
  }


  List<Results> get filteredItems => _filteredItems;

  List<Results> get movies => _movies;

  // void filtering(String text) {
  //   filteredItems.clear();
  //   for (int i = 0; i < movies.length; i++) {
  //     if (movies[i].title.contains(text)) {
  //       filteredItems.add(movies[i]);
  //     }
  //   }
  //   notifyListeners();
  // }

}