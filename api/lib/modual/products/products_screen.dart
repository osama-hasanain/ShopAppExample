import 'package:api/layout/cubit/cubit.dart';
import 'package:api/layout/cubit/states.dart';
import 'package:api/model/categories_model.dart';
import 'package:api/model/home_model.dart';
import 'package:api/shared/components/components.dart';
import 'package:api/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoriteState){
          if(!state.model.status!)
            showToast(text: state.model.message!, state: ToastState.ERROR);
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel !=null && ShopCubit.get(context).categoriesModel !=null,
          fallback:(context)=> Center(child: CircularProgressIndicator()),
          builder:(context)=> Center(child: productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context)),
        );
      },
    );
  }
  Widget productsBuilder(HomeModel homeModel,CategoriesModel categoriesModel,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: homeModel.data.banners.map((e) =>
                  Image(
                    image: NetworkImage('${e.image}',),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                  ).toList(),
                  options: CarouselOptions(
                    height: 200.0,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    scrollDirection: Axis.horizontal
                  )),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 25.0
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.data[index]),
                          separatorBuilder: (context,index)=> SizedBox(width: 10,),
                          itemCount: categoriesModel.data!.data.length),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'New Products',
                      style: TextStyle(
                          fontSize: 25.0
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.68,
                  children: List.generate(
                      homeModel.data.products.length,
                      (index) => buildGridProduct(homeModel.data.products[index],context),
                  ),
                ),
            ],
          ),
        ),
      );
  Widget buildCategoryItem(DataModel dataModel)=>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.network(
            dataModel.image!,
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Container(
            color: Colors.black.withOpacity(.8),
            width: 100,
            child: Text(
              dataModel.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  Widget buildGridProduct(Product product,context) =>
    Container(
      color: Colors.white,
      child: Column(
        children: [
         Stack(
           alignment: AlignmentDirectional.bottomStart,
           children: [
             Image.network(
               product.image,
               width: double.infinity,
               height: 200,
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
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                   product.name,
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                     fontSize: 14.0,
                     height: 1.3,
                   ),
                 ),
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
                     product.old_price.toString(),
                     style: TextStyle(
                       fontSize: 10.0,
                       color: Colors.grey,
                       decoration: TextDecoration.lineThrough,
                     ),
                   ),
                   Spacer(),
                   IconButton(
                     onPressed: (){
                       ShopCubit.get(context).changeFavorite(product.id);
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
               )
             ],
           ),
         )
        ],
      ),
    );
}
