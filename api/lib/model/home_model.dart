class HomeModel{
  late bool status;
  late HomeDataClass data;
  HomeModel.fromMap(Map<String,dynamic> map){
    this.status = map['status'];
    this.data = HomeDataClass.fromMap(map['data']);
  }
}
class HomeDataClass{
  late List<Banner> banners = [] ;
  late List<Product> products = [] ;
  HomeDataClass.fromMap(Map<String,dynamic> map){
    map['banners'].forEach((element){
      banners.add(Banner.fromMap(element));
    });
    map['products'].forEach((element){
      products.add(Product.fromMap(element));
    });
  }
}
class Banner{
  late int id;
  late String image;
  Banner.fromMap(Map<String,dynamic> map){
    this.id = map['id'];
    this.image = map['image'];
  }
}
class Product{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool in_favorites;
  late bool in_cart;
  Product.fromMap(Map<String,dynamic> map){
    this.id = map['id'];
    this.price = map['price'];
    this.old_price = map['old_price'];
    this.discount = map['discount'];
    this.image = map['image'];
    this.name = map['name'];
    this.description = map['description'];
    this.in_favorites = map['in_favorites'];
    this.in_cart = map['in_cart'];
  }
}