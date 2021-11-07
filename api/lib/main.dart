import 'dart:io';

import 'package:api/layout/cubit/cubit.dart';
import 'package:api/layout/shop_layout.dart';
import 'package:api/provider/themes.dart';
import 'package:api/shared/components/constant.dart';
import 'package:api/shared/network/local/cache_helper.dart';
import 'package:api/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/states.dart';
import 'modual/Login/login.dart';
import 'modual/onboarding/on_board.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getDate(key: 'onBoarding');
  token = CacheHelper.getDate(key: 'token');
  print(token);
  Widget widget = OnBoardingScreen();
  if(onBoarding) widget = ShopLoginScreen();
  if(token!=null) widget = ShopLayout();
  runApp(MyApp(widget));
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  Widget onBoarding ;
  MyApp(this.onBoarding);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context)=> ShopCubit()..getHomeDate()..getCategoriesDate()..getFavoritesDate()..getUserDate())
          ],
          child: BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state){},
           builder: (conttext,state){
             return MaterialApp(
               debugShowCheckedModeBanner: false,
               theme: lightTheme,
               home:onBoarding,
             );
           },
          )
      );
  }
}




