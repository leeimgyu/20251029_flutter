import 'package:ch07_splash_screen/splash_screen/mylist.dart';
import 'package:ch07_splash_screen/splash_screen/splash_body.dart';
import 'package:flutter/material.dart';

// StatelessWidget:: 상태가 없기 때문에 리렌더링 안됨.
// initState나 Timer 같은 생명주기 메서드를 가지고 있지 않음.
// 상태 관리(시간에 따른 화면 전환)가 핵심인 스플래시 화면을
// StatelessWidget으로 직접 변경하는 것은 불가능

class SplashScreenStateless extends StatelessWidget {
  const SplashScreenStateless({super.key});

  // FutureBuilder를 사용한 StatelessWidget 구성
  // FutureBuilder는 비동기 작업(예: 데이터 로딩, 딜레이)이 완료될 때까지
  // 로딩 화면을 보여주고, 완료된 후에는 다른 위젯을 띄우기가 가능
  // 비동기 딜레이를 처리하는 Future 함수
  Future<void> _delayAndNavigate(BuildContext context) async {
    // 2초 동안 대기합니다.
    await Future.delayed(Duration(seconds: 2));

    // 대기가 끝나면 Mylist 화면으로 이동하고 이전 화면(Splash)을 제거합니다.
    if (context.mounted) { // 위젯이 트리에 연결되어 있는지 확인
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mylist()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // FutureBuilder를 사용하여 화면이 빌드된 후 바로 비동기 작업을 시작합니다.
    return FutureBuilder(
      // FutureBuilder가 실행할 비동기 함수 지정
      future: _delayAndNavigate(context),
      builder: (context, snapshot) {
        // 비동기 작업의 완료 여부와 관계없이 스플래시 UI를 계속 표시합니다.
        // (단, _delayAndNavigate 함수 내에서 화면 전환이 이루어지므로,
        // 이 builder는 딜레이 시간 동안 로딩 화면을 보여주는 역할만 합니다.)
        return Scaffold(
          backgroundColor: Colors.yellow,
          body: Container( // sizedbox랑 차이점을 알것
            decoration: BoxDecoration(color: Colors.yellow),
            child: SplashBody(),
          ),
        );
      },
    );
  }
}
