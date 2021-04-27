import 'package:flutter/material.dart';
import 'package:flutter_app_middle/movie/results.dart';

class MovieDetailPage extends StatelessWidget {
  final List<Results> movies;
  final int i;
  MovieDetailPage(this.movies, this.i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(movies[i].title,
        style: TextStyle(
        ),),
      ),
      body: ListView(shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        children: [

        Column(
          children: [
            Text(movies[i].title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            Text('\'${movies[i].originalTitle}\'',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey
            ),),
            Image.network('https://image.tmdb.org/t/p/w500/${movies[i].posterPath}',height: 500,),
            SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('줄거리',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(219, 219, 219, 1),
                  border: Border.all(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movies[i].overview,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),
            )
          ],
        ),
        ]
      ),
    );
  }
}
