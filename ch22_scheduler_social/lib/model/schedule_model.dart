class ScheduleModel {
  final String id;
  final String content;
  final DateTime date;
  final int startTime;
  final int endTime;
  final List<String> sports; // 스포츠 종류 (축구, 농구, 배구)

  ScheduleModel({
    required this.id,
    required this.content,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.sports = const [], // 기본값은 빈 리스트
  });

  ScheduleModel.fromJson({ // JSON으로부터 모델을 만들어내는 생성자
    required Map<String, dynamic> json,
  })  : id = json['id'],
        content = json['content'],
        date = DateTime.parse(json['date']),
        startTime = json['startTime'],
        endTime = json['endTime'],
        sports = json['sports'] != null
            ? List<String>.from(json['sports'])
            : [];

  Map<String, dynamic> toJson() {  //  모델을 다시 JSON으로 변환하는 함수
    return {
      'id': id,
      'content': content,
      'date':
      '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
      'startTime': startTime,
      'endTime': endTime,
      'sports': sports,
    };
  }

  ScheduleModel copyWith({  // 현재 모델을 특정 속성만 변환해서 새로 생성
    String? id,
    String? content,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<String>? sports,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      content: content ?? this.content,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      sports: sports ?? this.sports,
    );
  }
}
