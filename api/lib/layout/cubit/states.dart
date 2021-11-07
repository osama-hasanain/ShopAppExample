import 'package:api/model/change_favorite_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}

class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessGetCategoriesState extends ShopStates{}
class ShopErrorGetCategoriesState extends ShopStates{
  String error;
  ShopErrorGetCategoriesState(this.error);
}

class ShopChangeFavoriteState extends ShopStates{}
class ShopSuccessChangeFavoriteState extends ShopStates{
  ChangeFavoriteModel model;
  ShopSuccessChangeFavoriteState(this.model);
}
class ShopErrorChangeFavoriteState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{
  String error;
  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingGetUserDataState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates{}
class ShopErrorGetUserDataState extends ShopStates{
  String error;
  ShopErrorGetUserDataState(this.error);
}

class ShopLoadingUpdateUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates{}
class ShopErrorUpdateUserDataState extends ShopStates{
  String error;
  ShopErrorUpdateUserDataState(this.error);
}

class ShopLoadingLogoutState extends ShopStates{}
class ShopSuccessLogoutState extends ShopStates{}
class ShopErrorLogoutState extends ShopStates{
  String error;
  ShopErrorLogoutState(this.error);
}
