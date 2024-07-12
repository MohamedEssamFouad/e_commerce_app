import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets.dart';
import '../../../core/shared/style/colors.dart';
import '../../../layout/layout_cubit/lay_out_cubit.dart';
import '../../../layout/layout_cubit/layout_states.dart';

class LayOutSCreen extends StatelessWidget {
  const LayOutSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(builder: (context, state){
      return    Scaffold(
          appBar: AppBar(
          backgroundColor: thirdColor,
          elevation: 0,
          title: SvgPicture.asset(

            APPvector.logo,

            height: 40.h,width: 40.h,color: mainColor,),
      ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: cubit.bottomIndex,
      selectedItemColor: mainColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index)
      {
      cubit.changeIndex(index: index);
      },
      items:
      const
      [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
      ],
      ),
      body: cubit.layoutScreen[cubit.bottomIndex],
      );
    } ,


    listener: (context, state) => {

    },);
  }
}
