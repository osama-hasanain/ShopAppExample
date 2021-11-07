import 'package:api/layout/shop_layout.dart';
import 'package:api/shared/components/components.dart';
import 'package:api/shared/components/constant.dart';
import 'package:api/shared/network/local/cache_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ShopRegisterScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
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
          if(state is ShopRegisterErrorState){
            print(state.error);
            showToast(
                text: state.error,
                state: ToastState.ERROR
            );
          }
        },
        builder: (context,state){
          var cubit = ShopRegisterCubit.get(context);
          return  Scaffold(
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
                            'REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            )
                        ),
                        Text(
                          'Register now to browse our hot offers',
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
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: nameController,
                            label: 'Full Name',
                            prefixIcon:Icon(Icons.person_outline),
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: phoneController,
                            label: 'Phone Number',
                            prefixIcon:Icon(Icons.phone_outlined),
                            type: TextInputType.number,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              return null;
                            }
                        ),
                        SizedBox(height: 10,),
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
                        state is ShopRegisterLoadingState?
                        Center(child: CircularProgressIndicator()) :
                        defaultButton(
                          text: 'register',
                          pressed: (){
                            if(formKey.currentState!.validate())
                            cubit.userRegister(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                password: passwordController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );;
        },
      ),
    );
  }
}
