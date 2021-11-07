import 'package:api/layout/cubit/states.dart';
import 'package:api/model/categories_model.dart';
import 'package:api/model/change_favorite_model.dart';
import 'package:api/model/favorite_model.dart';
import 'package:api/model/home_model.dart';
import 'package:api/model/shop_user_login/shop_user_model.dart';
import 'package:api/modual/cateogries/categories_screen.dart';
import 'package:api/modual/favorites/favorites_screen.dart';
import 'package:api/modual/products/products_screen.dart';
import 'package:api/modual/settings/settings_screen.dart';
import 'package:api/shared/components/constant.dart';
import 'package:api/shared/network/end_point.dart';
import 'package:api/shared/network/local/cache_helper.dart';
import 'package:api/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }
  HomeModel? homeModel;
  Map<int,bool> favorites = {};
  void getHomeDate(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getDate(
        url: HOME,
      auth: token
    ).then((value) {
      homeModel = HomeModel.fromMap(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.in_favorites
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((onError){
      print(onError);
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesDate(){
    DioHelper.getDate(
        url: GET_CATEGORIES,
        auth: token
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessGetCategoriesState());
    }).catchError((onError){
      print(onError);
    });
  }

  ChangeFavoriteModel? favoriteModel;
  void changeFavorite(int product_id){
    favorites[product_id] = !favorites[product_id]!;
    emit(ShopChangeFavoriteState());
    DioHelper.postDate(
        url: FAVORITES,
        auth: token,
        data: {
          'product_id':product_id
        }).then((value) {
          favoriteModel = ChangeFavoriteModel.fromMap(value.data!);
          if(!favoriteModel!.status!){
            favorites[product_id] = !favorites[product_id]!;
          }else{
            getFavoritesDate();
          }
          emit(ShopSuccessChangeFavoriteState(favoriteModel!));
        }).catchError((error){});
  }

  FavoritesModel? getFavoritesModel;
  void getFavoritesDate(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getDate(
        url: FAVORITES,
        auth: token
    ).then((value) {
      getFavoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetCategoriesState());
    }).catchError((onError){
      print(onError);
    });
  }

  ShopUserLogin? userDataModel;
  void getUserDate(){
    emit(ShopLoadingGetUserDataState());
    DioHelper.getDate(
        url: PROFILE,
        auth: token
    ).then((value) {
      userDataModel = ShopUserLogin.fromMap(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((onError){
      print(onError);
    });
  }

  void putUserDate({
    required String email,
    required String name,
    required String phone,
    required String password,
    }
    ){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putDate(
        url: UPDATE_PROFILE,
        auth: token,
        data:{
          'name':name,
          'email':email,
          'phone':phone,
          'password':password,
        }
    ).then((value) {
      userDataModel = ShopUserLogin.fromMap(value.data!);
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((onError){
      print(onError);
      emit(ShopErrorUpdateUserDataState(onError));
    });
  }

  // ShopUserLogin? modelLogout;
  // void signOut(){
  //   emit(ShopLoadingLogoutState());
  //   DioHelper.postDate(
  //       url: LOGOUT,
  //       auth: token,
  //       ).then((value) {
  //     modelLogout = ShopUserLogin.fromMap(value.data!);
  //     if(modelLogout!.status!){
  //       emit(ShopSuccessLogoutState());
  //     }else{
  //       emit(ShopErrorLogoutState(modelLogout!.message!));
  //     }
  //     emit(ShopSuccessChangeFavoriteState(favoriteModel!));
  //   }).catchError((error){});
  // }
}
