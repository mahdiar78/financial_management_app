class User {
  int? id;
  late String description;
  late String price;
  late String date;
  late int isRecieved;
  // 1==true    0==false

  User(
      {this.id,
      required this.description,
      required this.price,
      required this.date,
      required this.isRecieved});
  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "description" : description,
      "price" : price,
      "date" : date,
      "is_recieved" : isRecieved
    };
  }
}
