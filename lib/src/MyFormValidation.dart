import 'package:flutter/material.dart';

class MyFormValidation extends StatefulWidget {
  @override
  _MyFormValidationState createState() => _MyFormValidationState();
}

class _MyFormValidationState extends State<MyFormValidation> {
  final _formKey = GlobalKey<FormState>(); // Form 의 State 를 알아볼수 있는 키
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
              validator: (value) { // value 값이 들어왔을 때의 validate 규칙을 설정 할 수 있음.
                if (value.isEmpty) {
                  return '공백은 허용되지 않습니다.';
                }
              },
            ),// 텍스트 입력을 받는 메서드
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) { // formKey 의 FormState 가 Validate 하면,
                      // valid 하다면 할 동작
                      ScaffoldMessenger.of(_formKey.currentContext)
                          .showSnackBar(SnackBar(content: Text('처리중'),));
                    }
                  },
                  child: Text('완료'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
