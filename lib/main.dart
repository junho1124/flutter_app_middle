import 'package:flutter/material.dart';
import 'package:flutter_app_middle/src/MyFormValidation.dart';
import 'package:flutter_app_middle/src/MyOrientation.dart';
import 'package:flutter_app_middle/src/MySnackBar.dart';
import 'package:flutter_app_middle/src/MyTabController.dart';
import 'package:flutter_app_middle/src/animatedOpacity.dart';
import 'package:flutter_app_middle/src/myanimatedContainer.dart';
import 'package:flutter_app_middle/src/mydrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Tutorial'),
          ),
          body: Home()),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('AnimatedContainer'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAnimatedContainer()));
          },
        ),
        ListTile(
          title: Text('AnimatedOpacity'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAnimatedOpacity()));
          },
        ),
        ListTile(
          title: Text('Drawer'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyDrawer()));
          },
        ),
        ListTile(
          title: Text('SnackBar'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MySnackBar()));
          },
        ),
        ListTile(
          title: Text('Orientation'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyOrientation()));
          },
        ),
        ListTile(
          title: Text('TabController'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyTabController()));
          },
        ),
        ListTile(
          title: Text('FormValidation'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyFormValidation()));
          },
        )
      ],
    );
  }
}
