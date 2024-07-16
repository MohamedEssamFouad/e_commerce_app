
import 'package:e_commerce_app/core/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../layout/layout_cubit/lay_out_cubit.dart';
import '../../../layout/layout_cubit/layout_states.dart';
class Cart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
        body: BlocConsumer<LayoutCubit,LayoutStates>(
            listener:(context,state){},
            builder:(context,state){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                child: Column(
                  children:
                  [
                    Expanded(
                        child: cubit.cart.isNotEmpty ?
                        ListView.separated(
                            itemCount: cubit.cart.length,
                            separatorBuilder: (context,index){
                              return SizedBox(height: 12.h,);
                            },
                            itemBuilder: (context,index){
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: fourthColor
                                ),
                                child: Row(
                                  children:
                                  [
                                    Image.network(cubit.cart[index].image!,height: 100,width: 100,fit: BoxFit.fill,),
                                    SizedBox(width: 12.5.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:
                                        [
                                          Text(cubit.cart[index].name!,style: TextStyle(color: mainColor,fontSize: 17,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            children:
                                            [
                                              Text("${cubit.cart[index].price!} \$"),
                                              SizedBox(width: 5.w,),
                                              if( cubit.cart[index].price != cubit.cart[index].oldPrice)
                                                Text("${cubit.cart[index].oldPrice!} \$",style: TextStyle(decoration: TextDecoration.lineThrough),),
                                            ],
                                          ),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:
                                            [
                                              OutlinedButton(
                                                  onPressed: ()
                                                  {
                                                    cubit.addOrRemoveFromFavorites(productID: cubit.cart[index].id.toString());
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: cubit.favoritesID.contains(cubit.cart[index].id.toString()) ? Colors.red : Colors.grey,
                                                  )
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  cubit.addOrRemoveFromCard(id: cubit.cart[index].id!.toString());
                                                },
                                                child: const Icon(Icons.delete,color: Colors.red,),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        ) :
                        Center(child: Text("Loading....."),)
                    ),
                    Container(
                      child: Text("TotalPrice : ${cubit.totalP} \$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp,color: mainColor),),
                    )
                  ],
                ),
              );
            }
        )
    );
  }
}