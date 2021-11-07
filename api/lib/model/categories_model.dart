class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic> map){
    status = map['status'];
    data = CategoriesDataModel.fromJson(map['data']);
  }
}
class CategoriesDataModel{
  int? current_pager;
  List<DataModel> data = [];
  CategoriesDataModel.fromJson(Map<String,dynamic> map){
    current_pager = map['current_pager'];
    map['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel{
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String,dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.image = map['image'];
  }
}