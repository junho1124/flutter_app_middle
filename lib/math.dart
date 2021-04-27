import 'dart:io';

void main() {
  int input = int.parse(stdin.readLineSync());

  print(Solution(input));
}

int Solution(int input) {
  num result = 0;

  for (int i = 1; i <= input; i++) {
    if (input % i == 0) {
      result += i;
    }
  }
  return result;
}
