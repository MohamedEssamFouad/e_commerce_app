import 'package:e_commerce_app/layout/layout_cubit/lay_out_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/catModel.dart';

class CategoreirsScreen extends StatelessWidget {
  const CategoreirsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context).cat;

    //List<CatModel>catData=BlocProvider.of<LayoutCubit>(context).cat;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12,),
        child:GridView.builder(
            itemCount:cubit.length ,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
           mainAxisSpacing: 20,
          crossAxisSpacing: 15,
          crossAxisCount: 2,
        ), itemBuilder: (context,index){


          return  Card(
            shadowColor: Colors.grey,
            child: Container(
              child: Column(
                children: [
                  Expanded(child: Image.network(cubit[index].url!,fit: BoxFit.fill,)),
                  SizedBox(height: 10.h,),
                  Text(cubit[index].title!),

                ],
              ),
            ),
          );
        }) ,
      ),
    );
  }
}
