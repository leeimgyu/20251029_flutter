import 'package:camera/camera.dart';
import 'package:ch13_video_call/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

/* camera의 미리보기를 화면에 표시하는 기본적인 예제
late List<CameraDescription> _cameras;// 카메라목록을 저장할 변수

Future<void> main() async {
  // 필요한 라이브러리의 바인딩을 보장
  WidgetsFlutterBinding.ensureInitialized();
  // await 비동기로 카메라목록을 가져와 변수에 할당
  _cameras = await availableCameras();
  runApp(const CameraApp());
}

// 카메라의 상태에 따라 위젯을 렌더링하는 StatefulWidget
class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

// 카메라의 작동(초기화, 스트림 시작/중지, 촬영등)을 제어 위한 핵심객체
class _CameraAppState extends State<CameraApp> {
  late CameraController controller; // ref

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  // camera 초기화
  initializeCamera() async {
    try {   // _cameras[0]: 후면카메라, max: 가장 높은 해상도 설정
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      await controller.initialize();  //실제로 카메라 켜고 초기화 작업완료
      setState(() {}); // 초기화 성공후 위젯이 리렌더링되고 카메라 미리보기를 표시
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera accesss.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    }
  }

  @override  // 화면이 소멸될 때 리소스 해제
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 카메라 컨트롤러가 초기화되지 않을 경우 빈 컨테이너를 반환
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(home: CameraPreview(controller));
  }
}
*/