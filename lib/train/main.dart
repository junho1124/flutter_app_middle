import 'package:flutter/material.dart';
import 'train_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  movieResult _result;

  Future<movieResult> fetchData() async {
    var uri = Uri.parse('http://swopenAPI.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/${_myController.text}');
    var response = await http.get(uri);

    movieResult result = movieResult.fromJson(json.decode(response.body));

    return result;
  }


  final _myController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _myController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지하철 실시간 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _myController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: '역이름'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print('click');
                    fetchData().then((trainResult) {
                      setState(() {
                        _result = trainResult;
                        print(trainResult);
                      });
                    });
                  },
                  child: Text(
                    '조회',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ]),
            Expanded(
              child: _result == null
                  ? Center(child: Icon(Icons.train))
                  : GridView.count(
                scrollDirection: Axis.vertical,
                //스크롤 방향 조절
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                crossAxisCount: 2,
                //로우 혹은 컬럼수 조절 (필수값)
                children: List.generate(_result.realtimeArrivalList.length, (index) {
                  int sec = int.parse(_result.realtimeArrivalList.elementAt(index).barvlDt);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: lineColor(_result.realtimeArrivalList.elementAt(index).subwayId),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network('https://www.pngrepo.com/png/6283/180/subway.png', height: 100, width: 100,),
                          Text('${_result.realtimeArrivalList.elementAt(index).trainLineNm}'),
                          Text('${sec ~/ 60}분 ${sec % 60}초 ${aprochve(_result.realtimeArrivalList.elementAt(index).arvlCd)}'),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  lineColor(String subwayId) {
    Color result = Colors.amber;
    if (subwayId == '1001') {
      result = Colors.blueAccent;
    } else if(subwayId == '1002') {
      result = Colors.blueAccent;
    } else if(subwayId == '1003') {
      result = Colors.blueAccent;
    } else if(subwayId == '1004') {
      result = Colors.blueAccent;
    } else if(subwayId == '1005') {
      result = Colors.blueAccent;
    } else if(subwayId == '1006') {
      result = Colors.blueAccent;
    } else if(subwayId == '1007') {
      result = Colors.blueAccent;
    } else if(subwayId == '1008') {
      result = Colors.blueAccent;
    } else if(subwayId == '1009') {}
    return result;
  }

  aprochve(String arvlCd) {
    String result = '운행중';
    if (arvlCd == '0') {
      result = '진입';
    } else if (arvlCd == '1') {
      result = '도착';
    } else if (arvlCd == '2') {
      result = '출발';
    } else if (arvlCd == '3') {
      result = '전역출발';
    } else if (arvlCd == '4') {
      result = '전역진입';
    } else if (arvlCd == '5') {
      result = '전역도착';
    } return result;
  }
}
