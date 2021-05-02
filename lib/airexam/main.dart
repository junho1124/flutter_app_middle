import 'package:flutter/material.dart';
import 'package:flutter_app_middle/airexam/airResult.dart';
import 'package:flutter_app_middle/airexam/bloc/air_provider.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AirProvider())
    ],
        child: MaterialApp(
          title: 'Air Result',
          theme: ThemeData(
              primarySwatch: Colors.blue
          ),
          home: MyHomePage(),
        )
    );
  }
}

class MyHomePage extends StatelessWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
  // AirResult _result;
  //
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   fetchData().then((airResult) {
  //     setState(() {
  //       _result = airResult;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder<AirResult>(
              stream: context
                  .read<AirProvider>()
                  .airResult,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildBody(snapshot.data, context);
                } else {
                  return CircularProgressIndicator();
                }
              }
          )
      ),
    );
  }

  Widget buildBody(AirResult result, BuildContext context) {
    return Padding(
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
                          "${result.data.current.pollution.aqius}",
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(
                          getString(result),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    color: getColor(result),
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
                            Image.network(
                              'https://airvisual.com/images/${result.data
                                  .current.weather.ic}.png',
                              width: 32,
                              height: 32,),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "${result.data.current.weather.tp}도",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                            "습도 ${result.data.current.weather.hu}%"
                        ),
                        Text(
                            "풍속 ${result.data.current.weather.ws}m/s"
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
                      context.read<AirProvider>().fetch();
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(AirResult result) {
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

  String getString(AirResult result) {
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