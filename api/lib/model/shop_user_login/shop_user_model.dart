class ShopUserLogin{
  bool? status;
  String? message;
  UserModel? data;
  ShopUserLogin.fromMap(Map<String,dynamic> map){
    status = map['status'];
    message = map['message'];
    data = UserModel.fromMap(map['data']);
  }
  ShopUserLogin.fromMapLogout(Map<String,dynamic> map){
    status = map['status'];
    message = map['message'];
  }
}
class UserModel{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserModel.fromMap(Map<String,dynamic> map){
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
    points = map['points'];
    credit = map['credit'];
    token = map['token'];
  }
}