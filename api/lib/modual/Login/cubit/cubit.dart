import 'package:api/model/shop_user_login/shop_user_model.dart';
import 'package:api/modual/Login/cubit/states.dart';
import 'package:api/shared/network/end_point.dart';
import 'package:api/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopUserLogin? userMap;

  void userLogin({
    required String email,
    required String password
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postDate(
      url: LOGIN,
       data: {
      'email':email,
      'password':password,
    }).then((value) {
      userMap = ShopUserLogin.fromMap(value.data!);
      emit(ShopLoginSuccessState(userMap!));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    }).onError((error, stackTrace) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}