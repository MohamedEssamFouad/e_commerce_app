import 'package:e_commerce_app/core/shared/style/colors.dart';
import 'package:e_commerce_app/layout/layout_cubit/lay_out_cubit.dart';
import 'package:e_commerce_app/layout/layout_cubit/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fav extends StatelessWidget {
  const Fav({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body:Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 12.5.w),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),

                  ),
                ),
                SizedBox(height: 10.h,),
                Expanded(child: ListView.builder(
                  itemCount: cubit.Favv.length,
                    itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),

                    color: fourthColor,
                    child:  Row(
                      children: [
                        Image.network(cubit.Favv[index].image!,width: 120.w,height: 100.h,fit: BoxFit.fill,),
                        SizedBox(width: 7.w,),
                        Expanded(child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(cubit.Favv[index].name!,maxLines: 1,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                            Text(cubit.Favv[index].price!.toString()),
                            MaterialButton(onPressed: (){
                              cubit.addOrRemoveFromFavorites(productID: cubit.Favv[index].id.toString());
                            },
                            child: Text('Romove')
                              ,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),

                              ),
                              color: mainColor,
                            )
                          ],
                        )),
                      ],
                    ),
                  );
                })),
              ],
            ),
          ),
        );
      },
    );
  }
}
