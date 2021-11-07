import 'package:api/layout/cubit/cubit.dart';
import 'package:api/layout/cubit/states.dart';
import 'package:api/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
         if (state is ShopErrorUpdateUserDataState){
            showToast(
              text: state.error,
              state: ToastState.ERROR
            );
          }
         if (state is ShopSuccessUpdateUserDataState){
            showToast(
              text: 'Update done',
              state: ToastState.SUCCESS
            );
          }
        },
        builder:(context,state) {
          var model = ShopCubit.get(context).userDataModel!;
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return ConditionalBuilder(
              condition: ShopCubit.get(context).userDataModel!=null || !(state is ShopLoadingLogoutState),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateUserDataState)
                        LinearProgressIndicator(),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            label: 'Name',
                            controller: nameController,
                            prefixIcon: Icon(Icons.person),
                            validate: (value){
                              if(value!.isEmpty)
                                return 'must be not empty';
                              return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            label: 'Email Address',
                            controller: emailController,
                            prefixIcon: Icon(Icons.email),
                            validate: (value){
                              if(value!.isEmpty)
                                return 'must be not empty';
                              return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            label: 'Phone Number',
                            controller: phoneController,
                            prefixIcon: Icon(Icons.phone),
                            validate: (value){
                              if(value!.isEmpty)
                                return 'must be not empty';
                              return null;
                            }
                        ),
                        SizedBox(height: 15,),
                        defaultButton(
                            text: 'update',
                            pressed: (){
                              if(formKey.currentState!.validate())
                              ShopCubit.get(context).putUserDate(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text
                              );
                            }),
                        SizedBox(height: 10,),
                        defaultButton(
                            text: 'Logout',
                            pressed: (){
                              ShopCubit.get(context).currentIndex = 0 ;
                             logout(context);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            fallback: (context) => Center(child: CircularProgressIndicator(),)
          );
        }

    );
  }
}
