main(){
  // var 변수의 값이 들어가면 동적 할당 : 자동으로 타입을 추론된 일반 변수
  // 1. 업데이트 가능 , 2. 재선언 안됨, 3. 타입 고정이 됨

  // tot;  // type, var, const, final 중에 하나를 반드시 앞에 선언
  var name = "Dart";
  // name = 100; //  타입 고정이 됨


  var num; // 타입을 추론할 근거가 없기 때문에 dynamic으로 간주
  print(num);  // null
  print(num.runtimeType); // 객체로 인식함 Null
  num = "Hello Dart";
  print(num);
  print(num.runtimeType);  // runtimeType : 변수의 타입을 알기 위해 사용
  num = 100;
  print(num);
  num = true; // 업데이트 가능
  print(num);
  print(num.runtimeType);

  // var num= "1000"; // 재선언 안됨

}