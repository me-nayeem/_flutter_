void main() {
  double Exe1({
    required double height,
    required double width,
  }) {
    double area = height * width;
    return area;
  }

  void user({
    required String name,
    int? age,
  }) {
    if(age == null) {
      print("Hello $name");
    } else {
      print("Hello $name you are $age years old!");
    }
  }
  double area = Exe1(height: 10, width: 5);
  print("area: $area");

  user(name: "Nayeem");
  user(name: "Nayeem", age: 21);
}