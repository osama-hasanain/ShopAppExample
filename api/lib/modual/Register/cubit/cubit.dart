import 'package:api/model/shop_user_login/shop_user_model.dart';
import 'package:api/modual/Register/cubit/states.dart';
import 'package:api/shared/network/end_point.dart';
import 'package:api/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopUserLogin? userMap;

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postDate(
      url: REGISTER,
       data: {
      'email':email,
      'name':name,
      'phone':phone,
      'password':password,
    }).then((value) {
      userMap = ShopUserLogin.fromMap(value.data!);
      emit(ShopRegisterSuccessState(userMap!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    }).onError((error, stackTrace) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

}