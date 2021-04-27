import 'package:flutter/material.dart';
import 'package:flutter_app_middle/airexam/airResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TrainResult _result;

  Future<TrainResult> fetchData() async {
    var response = await http.get(
        'https://api.airvisual.com/v2/nearest_city?key=7d8906fb-ed70-4267-91f9-cd2011ac8277');

    TrainResult result = TrainResult.fromJson(json.decode(response.body));

    return result;
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _result == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "현재위치 미세먼지",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 16,
                ),
                Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Text("얼굴사진"),
                            Text(
                              "${_result.data.current.pollution.aqius}",
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              getString(_result),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        color: getColor(_result),
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.network('https://airvisual.com/images/${_result.data.current.weather.ic}.png',
                                width: 32,
                                height: 32,),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "${_result.data.current.weather.tp}도",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                                "습도 ${_result.data.current.weather.hu}%"
                            ),
                            Text(
                                "풍속 ${_result.data.current.weather.ws}m/s"
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                        child: Icon(Icons.refresh),
                        onPressed: () {
                          fetchData().then((airResult) {
                            setState(() {
                              _result = airResult;
                            });
                          });
                        },
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  Color getColor(TrainResult result) {
    if (result.data.current.pollution.aqius <= 50) {
      return Colors.greenAccent;
    } else if (result.data.current.pollution.aqius <= 100) {
      return Colors.yellow;
    } else if (result.data.current.pollution.aqius <= 150) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getString(TrainResult result) {
    if (result.data.current.pollution.aqius <= 50) {
      return '좋음';
    } else if (result.data.current.pollution.aqius <= 100) {
      return '보통';
    } else if (result.data.current.pollution.aqius <= 150) {
      return '나쁨';
    } else {
      return '최악';
    }
  }

}