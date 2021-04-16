import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyMethodChannel extends StatefulWidget {
  @override
  _MyMethodChannelState createState() => _MyMethodChannelState();
}

class _MyMethodChannelState extends State<MyMethodChannel> {
  static const platform = const MethodChannel('example.com/value'); // platform을 사용하여 네이티브코드(IOS, Android) 와 통신을 할 수 있다.

  String _value = 'nell';

  Future<void> _getNativeValue() async {
    String value;
    try {
      value = await platform.invokeMethod("getValue"); //안드로이드나 ios쪽에 getValue 라는 메서드를 실행시킬 것이다.
    } on PlatformException catch (e) {
      value = '네이티브 코드 실행에러 : ${e.message}';
    }

    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MethodChannel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_value'),
            ElevatedButton(
                onPressed: _getNativeValue,
                child: Text('네이티브 값 얻기')

            )
          ],
        ),
      ),
    );
  }
}
