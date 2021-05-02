import 'package:flutter/cupertino.dart';

import '../airResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirProvider extends ChangeNotifier{

  final _airSubject = BehaviorSubject<AirResult>();

  AirProvider() {
    fetch();
  }

  Future<AirResult> fetchData() async {
    var uri = Uri.parse('https://api.airvisual.com/v2/nearest_city?key=7d8906fb-ed70-4267-91f9-cd2011ac8277');
    var response = await http.get(uri);

    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  void fetch () async {
    print('fetch');
    var airResult = await fetchData();
    _airSubject.add(airResult);
    notifyListeners();
  }

  Stream<AirResult> get airResult => _airSubject.stream;

}