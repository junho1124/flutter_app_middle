import 'package:flutter/material.dart';

class MtSwipeToDismiss extends StatefulWidget {
  @override
  _MtSwipeToDismissState createState() => _MtSwipeToDismissState();
}

class _MtSwipeToDismissState extends State<MtSwipeToDismiss> {
  final items =
      List<String>.generate(20, (i) => 'item ${i + 1}'); // 리스트에 20개의 아이템을 만들겠다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Swipe To Dismiss"),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible( // 감싸진 아이템에 슬라이드하여 삭제하는 기능 추가 but 진짜로 리스트에서 사라지는 것은 아님 >>
                background: Container(color: Colors.white70,),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) { // Dismiss가 되었다면 items의 index번째 항목 삭제
                  setState(() {
                      items.removeAt(index);
                  });
                },
                key: Key(item),
                child: ListTile(
                  title: Text('${items[index]}'
                  ),
                ),
              );
            }));
  }
}
