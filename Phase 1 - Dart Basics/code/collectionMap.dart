void main(){
  Map<String, dynamic> User ={
    "name": "Nayeem",
    "age": 21,
    "email": "test@gmail.com",
  };

  print(User["name"]);
  print(User["age"]);

  User["country"] = "Bangladesh";
  User["age"] = 20;
  User.remove("email");
}