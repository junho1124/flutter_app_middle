import 'package:flutter/material.dart';
import 'package:flutter_app_middle/movie/detailPage.dart';
import 'package:flutter_app_middle/movie/movie_result.dart';
import 'results.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'movie',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Results> movies = [];
  final List<Results> filteredItems = [];
  final _controller = TextEditingController();

  Future<MovieResult> fetchData() async {
    var uri = Uri.parse(
        'http://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1');
    var response = await http.get(uri);

    MovieResult result = MovieResult.fromJson(json.decode(response.body));

    return result;
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((movieResult) {
      setState(() {
        for (int i = 0; i < movieResult.results.length; i++) {
          movies.add(movieResult.results[i]);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOLAN Movie',
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {
                filteredItems.clear();
                for (int i = 0; i < movies.length; i++) {
                  if (movies[i].title.contains(text)) {
                    filteredItems.add(movies[i]);
                  }
                }
              });
            },
            decoration: InputDecoration(labelText: '검색'),
          ),
          Expanded(
            child: GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 3,
                crossAxisCount: 3,
                childAspectRatio: 2 / 4,
                children: _buildItems(movies, context)
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItems(List<Results> movies, BuildContext context) {
    List<Widget> items = [];
    if (_controller.text.isEmpty) {
    makeItems(movies, items, context);
    } else {
      makeItems(filteredItems, items, context);
    }
    return items;
  }

  void makeItems(List<Results> movies, List<Widget> items, BuildContext context) {
    for (int i = 0; i < movies.length; i++) {
      items.add(
      Container(
        child: InkWell(
          splashColor: Colors.amberAccent.withAlpha(30),
          onTap: () {
          Navigator.push(
            context,
          MaterialPageRoute(builder: (context) => MovieDetailPage(movies, i)));
          },
          child: Card(
            shadowColor: Colors.blueGrey,
            color: Colors.amber,
             child: Column(
               children: [
                 Image.network('https://image.tmdb.org/t/p/w500/${movies[i].posterPath}'),
                 Container(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Padding(
                       padding: const EdgeInsets.only(top: 12.0),
                       child: Text(movies[i].title,
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold
                       ),),
                     ),
                   ),
                 ),
               ],
             ),
          ),
        )
      )
      );
    }
  }
}
