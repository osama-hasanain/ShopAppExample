import 'package:api/layout/cubit/cubit.dart';
import 'package:api/layout/cubit/states.dart';
import 'package:api/model/categories_model.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return
          ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel !=null,
            fallback:(context)=> Center(child: CircularProgressIndicator()),
            builder:(context)=>ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildCategoryItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
                    separatorBuilder:  (context,index)=>SizedBox(height: 10,),
                    itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length),
            );
      },
    );
  }
  Widget buildCategoryItem(DataModel model)=>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              model.image!,
              height: 100.0,
              width: 100.0,
            ),
            SizedBox(width: 15,),
            Text(
              model.name!,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      );
}
