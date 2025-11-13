import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// CustomVideoPlayer 위젯을 가져옴. (주어진 코드에는 정의되어 있지 않으므로 임시로 가정)
import 'package:ch12_media_player/component/custom_video_player.dart';

// HomeScreen 위젯 정의: 상태를 관리하는 StatefulWidget.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// HomeScreen의 상태를 관리하는 State 클래스.
class _HomeScreenState extends State<HomeScreen> {
  // 사용자가 선택한 동영상 파일을 저장하는 변수.
  // '?'는 null을 허용한다는 의미이며, 초기에는 동영상이 선택되지 않았으므로 null.
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 전체 배경색을 검은색으로 설정.

      // 동영상(video) 변수의 상태에 따라 다른 위젯을 보여줌.
      // video가 null이면 (선택 전) -> renderEmpty() 호출
      // video가 null이 아니면 (선택 후) -> renderVideo() 호출
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  // 동영상을 선택하기 전, 화면 중앙에 로고와 앱 이름을 보여주는 위젯.
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width, // 컨테이너의 넓이를 화면 전체로 설정.

      // 배경에 그라데이션을 적용하는 BoxDecoration을 사용.
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, // 상단 중앙에서 시작
          end: Alignment.bottomCenter, // 하단 중앙으로 끝나는 그라데이션
          colors: [Color(0xFF2A3A7C), Color(0xFF000118)], // 진한 파란색에서 거의 검은색으로
        ),
      ),
      child: Column(
        // 자식 위젯들을 세로 방향(Column)으로 가운데 정렬.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _Logo 위젯을 표시하며, 탭하면 onNewVideoPressed 함수를 실행하도록 연결.
          _Logo(onTap: onNewVideoPressed),
          SizedBox(height: 30.0), // 로고와 앱 이름 사이에 간격을 둠.
          _AppName(), // _AppName 위젯을 표시.
        ],
      ),
    );
  }

  // 로고나 '새 동영상' 버튼이 눌렸을 때 실행되는 콜백 함수.
  void onNewVideoPressed() async {
    // ImagePicker 패키지를 사용하여 갤러리에서 동영상을 선택하도록 사용자에게 요청.
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    // 동영상이 성공적으로 선택되었다면 (null이 아니라면)
    if (video != null) {
      // setState를 호출하여 위젯을 다시 빌드하고 상태를 업데이트.
      setState(() {
        this.video = video; // 선택된 동영상 파일(XFile)을 클래스 변수에 저장.
      });
    }
  }

  // 그라데이션 배경을 생성하는 함수. (현재 renderEmpty() 내에서 직접 사용되고 있음)
  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        // 그라데이션으로 색상 적용하기
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF2A3A7C), Color(0xFF000118)],
      ),
    );
  }

  // 동영상이 선택된 후, 동영상 재생을 위해 CustomVideoPlayer를 보여주는 위젯.
  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!, // 선택된 동영상 파일(video)을 CustomVideoPlayer에 전달. '!'는 null이 아님을 보장.
        onNewVideoPressed: onNewVideoPressed, // 새 동영상 선택 기능을 CustomVideoPlayer에 전달.
      ),
    );
  }
}

// 로고 이미지를 보여주는 위젯. (StatelessWidget)
class _Logo extends StatelessWidget {
  // 로고를 탭했을 때 실행할 콜백 함수를 필수로 받음.
  final GestureTapCallback onTap;

  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 탭 이벤트를 상위 위젯에서 받은 콜백 함수로 처리.
      child: Image.asset('assets/img/logo.png'), // 'assets/img/logo.png' 경로의 이미지를 표시.
    );
  }
}

// 앱 제목을 보여주는 위젯. (StatelessWidget)
class _AppName extends StatelessWidget {
  const _AppName();

  @override
  Widget build(BuildContext context) {
    // 기본 텍스트 스타일을 정의.
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300, // 얇은 글씨체
    );

    // 두 단어를 가로로 나란히 배치.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Row 내부의 위젯을 가운데 정렬.
      children: [
        Text('VIDEO', style: textStyle), // 'VIDEO'는 기본 스타일 (얇게)
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            // 기본 스타일을 복사하고 두께만 굵게 변경.
            fontWeight: FontWeight.w700, // 굵은 글씨체
          ),
        ),
      ],
    );
  }
}