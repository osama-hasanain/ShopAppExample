import 'package:api/model/shop_user_login/shop_user_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState{}
class ShopRegisterLoadingState extends ShopRegisterState{}
class ShopRegisterSuccessState extends ShopRegisterState{
  ShopUserLogin userMap;
  ShopRegisterSuccessState(this.userMap);
}
class ShopRegisterErrorState extends ShopRegisterState{
  String error;
  ShopRegisterErrorState(this.error);
}