
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'movie',
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = ["go", 'dfjidl', 'fdjsk'];

  final List<String> filteredItems = [];

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello world'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {
                filteredItems.clear();
                // for (String item in items) {
                //   if (item.contains(text)) {
                //     filteredItems.add(item);
                //   }
              // }
                filteredItems.addAll(items.where((item) => item.contains(text)));
              });
            },
          ),
          ListView(
            shrinkWrap: true,
            children: _buildItems(),
          )
        ],
      ),
    );
  }

  List<ListTile> _buildItems() {
    if (_controller.text.isEmpty) {
      return items.map((e) => ListTile(Text(e))).toList();
    }
    return filteredItems.map((e) => ListTile(title: Text(e))).toList();
  }
}
