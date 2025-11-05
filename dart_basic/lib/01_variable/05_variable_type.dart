import 'package:dart_basic/01_variable/Person.dart';

main() {
  // 변수의 타입으로 선언시 : 업뎃(O), 재선언(X), 타입 고정(O)
  // dart 언어에서 변수의 종류 : bool, int, double, String
  // null, Collection(List, Set, Map)

  bool isBool = false;
  print(isBool);
  print(isBool.runtimeType);

  int isInt = 100;
  print(isInt);
  print(isInt.runtimeType);

  double isDouble = 100;
  print(isDouble);
  print(isDouble.runtimeType);

  String name;
  name = 'Hello';
  name = 'World';

  // String name; //재선언 불가
  // name  = 100; // 타입 변경 불가

  // 변수의 명명규칙
  // 변수는 반드시 문자 또는 '_'로 시작해야 한다.
  // 변수는 글자, 숫자, '_', '$' 의 조합으로 선언.
  // CamelCase, SnakeCase, 케밥표기법 등 다 되지만, 일관성 있게 작성요!

  // 기본 타입 형 변환(Primitive Type Casting)
  // 기본형 타입에서 자동 형변환은 없다. 대부분 명시적인 형변환!

  int a = 10;
  double b = a.toDouble();
  print(b); // 10.0

  double d = 3.14;
  int c = d.toInt();
  print(c);

  String str = "123";
  int num = int.parse(str);
  print(num);

  int num2 = 42;
  String str2 = num2.toString();
  print(str2);
  print(str2.runtimeType);
  print(str + 10.toString()); // 숫자와 문자의 연산시 반드시 타입을 일치!

  double dnum = double.parse("3.141592"); // String -> double
  print(dnum);
  print(dnum.runtimeType);

  print("===================");
  double d2 = 5.672;
  String str3 = d2.toString(); // double -> String
  print(str3); // 5.672

  print("===================");
  // double -> String(소수점 조절)
  // 소수점 이하를 지정한 자릿수까지 잘라서 출력
  // 소수점 1자리까지 고정해서 보여줌(2번째 자리에서 반올림)
  String str4 = d2.toStringAsFixed(1);
  print("str4: " + str4); // 5.7

  print("===================");
  // 전체 자릿수(정수+소수)를 지정한 만큼 출력
  // 정말한 과학 계산이나 공학 분야에서 유효 숫자를 표현할 때 유용, 지수표기법로도 표시가능
  // 전체 자릿수를 1개로 보여줌(2번째 자리에서 반올림)
  String str5 = d2.toStringAsPrecision(1); //
  print("str5: " + str5); // 6

  print("===================");
  // 항상 지수 표기법으로 변환해서 출력
  // 아주 크거나 작은 숫자를 간결하게 표현할 때 사용
  // 지수 형태로 표현하되, 소수점은 1자리까지
  String str6 = d2.toStringAsExponential(1);
  print("str6: " + str6); // 5.7e+0

  // Person p = Person(10); // 다른 파일의 '_변수'는 외부에서 접근 불가
  // print(p._pno);
  // p.pno;

  Temp t = Temp();
  print(t._tno);
}
// _로 시작한 변수는 해당(lib)내부에서만 접근,
// 외부 파일에서는 접근 불가능
class Temp {
  int _tno = 10;
}


// 변수 앞에 붙을 수 있는 제어자
// : var, dynamic, const, final, '_'