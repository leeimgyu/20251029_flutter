void main() {

  Dog dog = Dog("댕댕이");
  print(dog);
  dog.sound();
  dog.bark();
}

// 상속 가능 요소 : 인스턴스 변수( _로 시작하는 변수 제외) 및 메서드, Getter/Setter
// 상속 불가 요소 : 생성자, static 변수 및 메서드, _로 시작하는 변수,

class Animal {
  late String _name;
  Animal.withVal(this._name);
  void sound() {
    print('$_name sound~!');
  }
  @override
  String toString() {return _name;}
}
class Dog extends Animal {
  Dog(super.name) : super.withVal();
  void bark() {
    print("$_name bow bow!");
  }
}