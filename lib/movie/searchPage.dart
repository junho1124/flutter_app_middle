import 'package:flutter/material.dart';
import 'package:flutter_app_middle/movie/detailPage.dart';
import 'package:flutter_app_middle/movie/movie_provider.dart';
import 'package:provider/provider.dart';
import 'results.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'movie',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider())
      ],
      child: MyHomePage(),),
    );
  }
}


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController(); //controller 는 굳이 provider 로 안 쓰는게 목적에 맞다고 한다...

  @override
  void initState() { //TODO initState 안쓰고도 할 수 있는 방법 없나,,,,,
    super.initState();

    context.read<MovieProvider>().fetchData().then((movieResult) {
      setState(() {
        for (int i = 0; i < movieResult.results.length; i++) {
          context.read<MovieProvider>().movies.add(movieResult.results[i]);
        }
      });
    });
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
              // context.read<MovieProvider>().filtering(text); TODO 왜 안되는지 알아보기
              setState(() {
                context.read<MovieProvider>().filteredItems.clear();
                for (int i = 0; i < context.read<MovieProvider>().movies.length; i++) {
                  if (context.read<MovieProvider>().movies[i].title.contains(text)) {
                    context.read<MovieProvider>().filteredItems.add(context.read<MovieProvider>().movies[i]);
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
                children: _buildItems(context.read<MovieProvider>().movies, context)
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
      makeItems(context.read<MovieProvider>().filteredItems, items, context);
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
          MaterialPageRoute(builder: (context) => MovieDetailPage(movies[i])));
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
