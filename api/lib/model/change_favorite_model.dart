class ChangeFavoriteModel{
  bool? status;
  String? message;
  ChangeFavoriteModel.fromMap(Map<String,dynamic> map){
    status = map['status'];
    message = map['message'];
  }
}