import 'package:api/layout/cubit/cubit.dart';
import 'package:api/layout/cubit/states.dart';
import 'package:api/model/favorite_model.dart';
import 'package:api/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)=>{},
      builder: (context,state)=>ConditionalBuilder(
        condition:  state is! ShopLoadingGetFavoritesState,
        fallback:(context)=> Center(child: CircularProgressIndicator()),
        builder:(context)=> ListView.separated(
            itemBuilder: (context,index)=>favoriteItemView(ShopCubit.get(context).getFavoritesModel!.data!.data[index].product!),
            separatorBuilder:(context,index)=>SizedBox(height: 2,),
            itemCount: ShopCubit.get(context).getFavoritesModel!.data!.data.length
        ),
      )
    );
  }

  Widget favoriteItemView(Product product) =>
      ShopCubit.get(context).favorites[product.id]==null?
      SizedBox():
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.network(
                      product.image!,
                      width: 120,
                      height: 120,
                    ),
                    if(product.discount!=0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          product.price.toString(),
                          style: TextStyle(
                              fontSize: 12.0,
                              color: defultColor
                          ),
                        ),
                        SizedBox(width: 5,),
                        if(product.discount != 0)
                          Text(
                            product.oldPrice!.toString(),
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: (){
                              ShopCubit.get(context).changeFavorite(product.id!);
                            },
                            icon: CircleAvatar(
                                backgroundColor: ShopCubit.get(context).favorites[product.id]!?defultColor:Colors.grey,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 18.0,
                                )
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
