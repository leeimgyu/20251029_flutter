import 'package:ch20_scheduler_firebase/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ch20_scheduler_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // firebase : 모바일 앱 개발에 최적화된 기능을 제공하는 서비스
  // firebase 프로젝트 설정 함수
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}
