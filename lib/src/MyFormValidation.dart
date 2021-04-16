import 'package:flutter/material.dart';

class MyFormValidation extends StatefulWidget {
  @override
  _MyFormValidationState createState() => _MyFormValidationState();
}

class _MyFormValidationState extends State<MyFormValidation> {
  final _formKey = GlobalKey<FormState>(); // Form 의 State 를 알아볼수 있는 키
  FocusNode nameFocusNode; // 사용 하려면 생성 해주고 해제를 해주어야 함

  final nameController = TextEditingController();

  @override
  void initState() {
    //생성
    super.initState();
    nameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    //해제
    super.dispose();
    nameFocusNode.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: Form(
        key: _formKey, // _formKey를 통해서 FormState를 알수가 있게됨.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 컬럼들을 왼쪽부처 정렬 하겠다.
          children: [
            TextFormField(
              // ignore: missing_return
              validator: (value) {
                // value 값이 들어왔을 때의 validate 규칙을 설정 할 수 있음.
                if (value.isEmpty) {
                  return '공백은 허용되지 않습니다.';
                }
              },
            ), // 텍스트 입력을 받는 메서드
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // formKey 의 FormState 가 Validate 하면,
                    // valid 하다면 할 동작
                    ScaffoldMessenger.of(_formKey.currentContext)
                        .showSnackBar(SnackBar(
                      content: Text('처리중'),
                    ));
                  }
                },
                child: Text('완료'),
              ),
            ),
            TextField(
              controller: nameController,
              onChanged: (text) {
                // 텍스트가 변경 될 때마다 호출 됨
                print(text);
              },
              focusNode: nameFocusNode,
              decoration: InputDecoration(
                  hintText: '이름을 입력 해 주세요.', // 텍스트가 비어있을 때 보여줄 텍스트
                  border: InputBorder.none, // 입역창의 밑줄을 없애 줌
                  labelText: '이름' //텍스트 필드 위에 라벨텍스트 삽입
                  ),
              autofocus: true, //화면이 전환 될 때 자동으로 입력 커서를 둠
            ), // 그냥 입력 할 수 있는 입력창
            ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(nameFocusNode);
                },
                child: Text('포커스')),
            ElevatedButton(
                onPressed: () {
                  print(nameController.text);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(nameController.text),
                        );
                      });
                },
                child: Text('textField 값 확인'))
          ],
        ),
      ),
    );
  }
}
