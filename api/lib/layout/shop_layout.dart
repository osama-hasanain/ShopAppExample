import 'package:api/layout/cubit/cubit.dart';
import 'package:api/layout/cubit/states.dart';
import 'package:api/modual/search/search_screen.dart';
import 'package:api/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatefulWidget {
  @override
  _ShopLayoutState createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
           appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  navigate(context,SearchsScreen());
                }
          )
            ],
           ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
               label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),
        );
        }
      );
  }
}

