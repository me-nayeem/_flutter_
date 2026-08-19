void main() {
  List<String> Languages = ["TypeScript", "C++", "Python", "Java", "Dart"];
  String firstLan = Languages.first;
  print("First Language: $firstLan");
  Languages.add("GO");
  Languages.remove("Dart");
  int length = Languages.length;
  print("Length: $length");
  int count = 1;
  for(String lan in Languages) {
    print("$count. $lan");
    count++;
  }



  List<int> numbers = [5,12,32,4,120,32,1];
  final gaterThan10 = numbers.where((num) => num > 10);
  print(gaterThan10);
  final doubled = numbers.map((num) => num * 2);
  print(doubled);
}