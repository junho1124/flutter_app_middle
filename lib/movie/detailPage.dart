import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final movies;

  MovieDetailPage(this.movies);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          movies.title,
          style: TextStyle(),
        ),
      ),
      body:
          ListView(shrinkWrap: true, padding: EdgeInsets.all(15.0), children: [
        Column(
          children: [
            Text(
              movies.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              '\'${movies.originalTitle}\'',
              style: TextStyle(fontSize: 20, color: Colors.blueGrey),
            ),
            Image.network(
              'https://image.tmdb.org/t/p/w500/${movies.posterPath}',
              height: 500,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '줄거리',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '개봉일: ${movies.releaseDate}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amberAccent,
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              movies.voteCount.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.check,
                              size: 15,
                            )
                          ],
                        )),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amberAccent,
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(movies.voteAverage.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.star_border,
                            size: 15,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(219, 219, 219, 1),
                  // border: Border.all(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movies.overview,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
