import 'package:api/model/shop_user_login/shop_user_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState{}
class ShopLoginLoadingState extends ShopLoginState{}
class ShopLoginSuccessState extends ShopLoginState{
  ShopUserLogin userMap;
  ShopLoginSuccessState(this.userMap);
}
class ShopLoginErrorState extends ShopLoginState{
  String error;
  ShopLoginErrorState(this.error);
}