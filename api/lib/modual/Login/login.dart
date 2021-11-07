import 'package:api/layout/shop_layout.dart';
import 'package:api/modual/Login/cubit/cubit.dart';
import 'package:api/modual/Login/cubit/states.dart';
import 'package:api/modual/Register/register.dart';
import 'package:api/shared/components/components.dart';
import 'package:api/shared/components/constant.dart';
import 'package:api/shared/network/local/cache_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ShopLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.userMap.status!) {
              CacheHelper.saveData(
                  key: 'token',
                  value: state.userMap.data!.token
              ).then((value){
                token = state.userMap.data!.token!;
                navigateToAndFinish(context,ShopLayout());
              });
            }else {
              showToast(
                text: state.userMap.message!,
                state: ToastState.ERROR
              );
            }
          }
          if(state is ShopLoginErrorState){
            print(state.error);
            showToast(
                text: state.error,
                state: ToastState.ERROR
            );
          }
        },
        builder: (context,state){
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            )
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            controller: emailController,
                            label: 'Email Address',
                            prefixIcon:Icon(Icons.email_outlined),
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              else if (!EmailValidator.validate(value))
                                return 'required a valid email';
                              return null;
                            }
                        ),SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: passwordController,
                            label: 'Password',
                            prefixIcon:Icon(Icons.lock_outline_sharp),
                            suffixIcon: isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined,
                            isPassword :isPassword,
                            onPasPres: (){
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              return null;
                            }
                        ),
                        SizedBox(height: 30,),
                       state is ShopLoginLoadingState?
                        Center(child: CircularProgressIndicator()) :
                       defaultButton(
                            text: 'login',
                            pressed: (){
                              if(formKey.currentState!.validate())
                                cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                            },
                          ),

                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                                text: 'register',
                                onPressed: (){
                                  navigate(context,ShopRegisterScreen());
                                }
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
