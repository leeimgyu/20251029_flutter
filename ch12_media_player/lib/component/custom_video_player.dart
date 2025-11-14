import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:ch12_media_player/component/custom_icon_button.dart';

// CustomVideoPlayer 위젯: 동영상 재생을 담당하는 StatefulWidget
class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상 파일 (상위 위젯에서 전달받음)
  final XFile video;

  // 새 동영상 선택 기능을 실행하는 콜백 함수 (상위 위젯으로 전달)
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video, // 상위에서 선택한 동영상 파일 주입 (필수)
    required this.onNewVideoPressed, // 새 동영상 선택 버튼 콜백 (필수)
    super.key,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

// CustomVideoPlayer의 상태를 관리하는 State 클래스
class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // 동영상 재생을 제어하는 컨트롤러
  VideoPlayerController? videoController;

  // 컨트롤 UI (재생 버튼, 슬라이더 등)의 표시 여부를 결정하는 상태 변수
  bool showControls = true;

  @override
  // covariant 키워드는 CustomVideoPlayer 클래스의 상속된 값도 허가해줍니다. 217p
  // 위젯의 설정(properties)이 변경될 때 호출되는 생명주기 함수
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    // 상위 클래스의 didUpdateWidget 호출
    super.didUpdateWidget(oldWidget); // 생성자의 매개변수가 변경시 생명주기 함수 호출

    // 새로 전달받은 동영상 파일의 경로가 이전과 다를 경우 (새 동영상이 선택된 경우)
    if (oldWidget.video.path != widget.video.path) {
      initializeController(); // 컨트롤러를 새로 초기화합니다.
    }
  }

  @override
  void initState() {
    super.initState();

    initializeController(); // State가 생성될 때 컨트롤러 초기화
  }

  // VideoPlayerController를 초기화하는 비동기 함수
  initializeController() async {
    // XFile 경로를 사용하여 File 객체로 컨트롤러를 생성하고 초기화. 선택한 동영상으로 컨트롤러 초기화
    final videoController = VideoPlayerController.file(File(widget.video.path));

    await videoController.initialize(); // 동영상 로딩 및 초기화 완료 대기

    // 컨트롤러의 상태가 변경될 때마다 호출될 리스너를 등록
    videoController.addListener(videoControllerListener);
    // 상태를 업데이트하여 위젯을 다시 빌드하고 새로운 컨트롤러를 적용
    setState(() {
      this.videoController = videoController;
    });
  }

  // VideoPlayerController의 상태 변경을 감지하고 setState()를 호출하는 리스너 함수
  void videoControllerListener() {
    // 재생 위치, 상태 등 변경 사항을 화면에 반영하기 위해 rebuild를 요청
    setState(() {});
  }

  @override
  // 위젯이 영구적으로 제거될 때 호출되는 생명주기 함수 (리소스 해제)
  void dispose() {
    // 메모리 누수를 방지하기 위해 리스너를 제거하고 컨트롤러를 해제합니다.
    videoController?.removeListener(videoControllerListener);
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 컨트롤러 초기화 중일 경우 로딩 인디케이터를 표시
    if (videoController == null) {
      return Center(child: CircularProgressIndicator());
    }

    // 화면 전체의 탭을 감지하여 컨트롤 UI를 토글
    return GestureDetector(
      // 화면 전체의 탭을 인식하기 위해 사용
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      // 동영상의 비율(Aspect Ratio)을 유지하며 화면에 표시
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack(
          // children 위젯을 위로 쌓을 수 있는 위젯
          children: [
            // 1. 동영상 플레이어 자체. VideoPlayer 위젯을 Stack으로 이동
            VideoPlayer(videoController!),
            // 2. 컨트롤 UI가 표시될 때 화면을 어둡게 만드는 오버레이
            if (showControls)
              Container(
                //  아이콘 버튼을 보일 때 화면을 어둡게 변경
                color: Colors.black.withAlpha(125),
              ),
            // 3. 동영상 재생 시간 및 슬라이더 (하단에 위치)
            if (showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      // 현재 재생 시간 텍스트
                      renderTimeTextFromDuration(
                        videoController!.value.position,
                      ),
                      Expanded(
                        // Slider가 남는 공간을 모두 차지하도록 구현
                        child: Slider(
                          // 슬라이더를 움직였을 때 동영상 재생 위치를 변경
                          onChanged: (double val) {
                            videoController!.seekTo(
                              Duration(seconds: val.toInt()),// 초 단위로 위치 이동
                            );
                          },
                          //  슬라이더의 현재 위치 (현재 재생 위치의 초 단위)
                          value: videoController!.value.position.inSeconds
                              .toDouble(),
                          // 슬라이더의 최소값 (0초)
                          min: 0,
                          // 슬라이더의 최대값 (동영상의 총 길이)
                          max: videoController!.value.duration.inSeconds
                              .toDouble(),
                        ),
                      ),
                      renderTimeTextFromDuration(
                        // 동영상 총 길이
                        videoController!.value.duration,
                      ),
                    ],
                  ),
                ),
              ),
            // 4. 새 동영상 선택 버튼 (우측 상단에 위치)
            if (showControls)
              Align(
                // 오른쪽 위에 새 동영상 아이콘 위치
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  onPressed: widget.onNewVideoPressed,
                  iconData: Icons.photo_camera_back,// 카메라 아이콘
                ),
              ),
            // 5. 재생, 되감기, 빨리 감기 버튼 (중앙에 위치)
            if (showControls)
              Align(
                // 동영상 재생관련 아이콘 중앙에 위치
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      // 되감기 버튼
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    CustomIconButton(
                      // 재생/일시정지 버튼 (현재 재생 상태에 따라 아이콘 변경)
                      onPressed: onPlayPressed,
                      iconData: videoController!.value.isPlaying// 현재재생 중이면
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    CustomIconButton(
                      // 앞으로 감기 버튼
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Duration 객체를 'MM:SS' 형식의 텍스트 위젯으로 변환하는 함수
  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      // 분(minutes)을 두 자리로, 초(seconds)를 두 자리로 표시 ('00:00' 형태)
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(color: Colors.white),
    );
  }

  // 되감기 버튼 눌렀을 때 실행할 함수 (3초 뒤로 이동)
  void onReversePressed() {
    final currentPosition = videoController!.value.position; // 현재 실행 중인 위치

    Duration position = Duration(); // 새로운 플레이 위치를 담기 위한 변수

    if (currentPosition.inSeconds > 3) {
      // 현재 실행위치가 3초보다 길때만 3초 빼기
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    // 앞으로 감기 버튼 눌렀을 때 실행할 함수
    final maxPosition = videoController!.value.duration; // 동영상 길이
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition; // 동영상 길이로 실행 위치 초기화

    // 동영상 길이에서 3초를 뺀 값보다 현재 위치가 짧을 때만 3초 더하기
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    //  재생 버튼을 눌렀을 때 실행할 함수
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }
}
