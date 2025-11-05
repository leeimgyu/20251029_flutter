// 추상 클래스
void main() {

}

abstract class Unit {
  final String name;
  final String tribe;
  void move() {print("Move! Move!");}
  void stop() {print("Stop! Stop!");}
  void attack();
  Unit(this.name, this.tribe);

  // 추상 클래스는 직접 인스턴스를 생성하지 못한다
  @override
  String toString() {return 'Unit{name: $name, tribe: $tribe}';}
}
class Terran extends Unit {
  Terran():super("Marine", "Terran"){
    print("$tribe 종족 $name이 나타났습니다.");
  }
  @override
  void attack() {print("빵야 빵야");}
}
