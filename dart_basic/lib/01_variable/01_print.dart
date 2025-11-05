import 'dart:io';

main() {
  // 한 줄 주석 : ctrl  + '/'
  // 여러 줄 주석 : ctrl + shift + '/'

  // main() 실행하는 명령 : ctrl + shift + F10
  print("=" * 30);
  print("🐙${10}");
  for (var i = 0; i < 10; i++) {
    print('hello ${i + 1}');
  }
  String text = 'Hello';
  String repeated = List.generate(3, (_) => text).join();
  print(repeated);
  for(int i =0;i<10;i++) {
    stdout.write(i); // 개행 없이 출력 (줄바꿈이 없다)
  }
}

