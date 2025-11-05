// dart언어에서 람다함수는 단 하나의 스테이트먼트를 가진다.

void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  var squared = numbers.map((n) => n*n);
  print(squared);print(squared.runtimeType);
  squared = squared.toList();
  print(squared.runtimeType);
  final sumNumbers = numbers.reduce((value, element)=>value + element);
  print(sumNumbers); print(sumNumbers.runtimeType);

  // 2) 람다식으로 함수 선언
  var add = (int a, int b) => a + b; // return이 생략되어있음
  print(add(3,5)); // 복수가 될려면 익명함수를 사용해야함

  var sum = (a) => a* a; // 매개변수가 하나가 있어도 ()필요

  // 3) statement가 복수개 일 경우 익명함수
  var greet = (String str) {
    str += "동에 번쩍 서에 번쩍";
    print('Hello ${str}');
  };
  greet('홍길동');
}



