class Cons{
  final String name;
  final int age; 
  String nameAge;
  Cons(this.name, this.age):
    nameAge = "name: $name and age: $age";
    
  Cons.guest(int age):
    name = "guest",
    this.age = age,
    nameAge = "Guest age is 0";
}

class Book{
  final String title;
  final String author;
  final int price;

  Book({
    required this.title,
    required this.author,
    this.price = 0,
  });

  Book.free(String title, String author):
  this.title = title,
  this. author = author,
  this.price = 0;
}


void main() {
  Cons user = Cons.guest(20);
  print(user.name);
  print(user.age);
  print(user.nameAge);

  Cons user1 = Cons("Namyeem", 20);
  print(user1.name);
  print(user1.age);
  print(user1.nameAge);

  Book book = Book(title: "Book random", author: "Unknown", price: 100);
  Book freeBook = Book.free("free book", "Someone");
  print(book.title);
  print(book.author);
  print(book.price);

  print(freeBook.title);
  print(freeBook.author);
  print(freeBook.price);

}