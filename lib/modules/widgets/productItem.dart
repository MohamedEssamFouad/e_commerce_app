import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../layout/layout_cubit/lay_out_cubit.dart';
import '../../model/ProductModel.dart';


class prucductitems extends StatelessWidget {
  const prucductitems({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return  GridView.builder(

        physics: NeverScrollableScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 12,
      childAspectRatio: 0.8,



    ),shrinkWrap: true,
        itemCount: cubit.filtered.isEmpty? cubit.product.length:cubit.filtered.length,
        itemBuilder: (context,index){
          return productItem(
            cubit: cubit,
            model: cubit.filtered.isEmpty?cubit.product[index]:cubit.filtered[index],
          );
        });
  }
}

Widget productItem({required ProductModel model,required LayoutCubit cubit}){
  return Container(
    color:Colors.grey.withOpacity(0.2) ,
    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
    child: Column(
      children: [
        Expanded(child: Image.network(model.image!)),
        Text(model.name!,style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
        Row(
          children: [
            Text('${model.price!}\$',style: TextStyle(fontSize:14.sp,overflow: TextOverflow.ellipsis),),
            SizedBox(width: 20.h,),
            Text('${model.oldPrice!}\$'.toString(),style: TextStyle(fontSize: 14.sp,decoration: TextDecoration.lineThrough),),
            Spacer(),
            GestureDetector(
              onTap: (){
                cubit.addOrRemoveFromFavorites(productID: model.id.toString());

              },
              child: Icon(
                Icons.favorite,size: 20,
                color: cubit.favoritesID.contains(model.id.toString())?Colors.red:Colors.grey,
              ),
            ),


          ],
        ),
      ],
    ),
  );
}