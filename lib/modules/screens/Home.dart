import 'package:e_commerce_app/layout/layout_cubit/lay_out_cubit.dart';
import 'package:e_commerce_app/layout/layout_cubit/layout_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/shared/style/colors.dart';
class Home extends StatelessWidget {
  final pageController=PageController();
   Home({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                TextFormField(

                  
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.3),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.clear),
                    border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                cubit.banners.isEmpty?Center(child: CupertinoActivityIndicator(),):
                SizedBox(height: 125.h, width: double.infinity,

                  child: PageView.builder(
                    controller: pageController,
                    physics: BouncingScrollPhysics(),

                      itemCount: cubit.banners.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 12),
                          child: Image.network(cubit.banners[index].url!,fit: BoxFit.fill,),
                        );
                      }),

                ),
        SizedBox(height: 15,),
        Center(
          child: SmoothPageIndicator(
          controller: pageController,
          count: cubit.banners.length,
          axisDirection: Axis.horizontal,
          effect: const SlideEffect(
          spacing: 8.0,
          radius:  25,
          dotWidth:  16,
          dotHeight:  16.0,
          paintStyle: PaintingStyle.stroke,
          strokeWidth:  1.5,
          dotColor:  Colors.grey,
          activeDotColor: secondColor)

          ),
        ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories',style: TextStyle(color: mainColor,fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('View all',style: TextStyle(color: secondColor,fontSize: 14,fontWeight: FontWeight.bold),),


                  ],
                ),
                SizedBox(height: 15,),
                cubit.cat.isEmpty?const Center(child: CupertinoActivityIndicator(),):
                SizedBox(height: 70.h, width: double.infinity,

                  child: ListView.separated(
                    separatorBuilder: (context,index){
                      return SizedBox(width: 15.w,);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,

                      physics: BouncingScrollPhysics(),

                      itemCount: cubit.cat.length,
                      itemBuilder: (context, index) {
                        return CircleAvatar(

                    radius: 40,
                          backgroundImage: NetworkImage(cubit.banners[index].url!),
                        );
                      }),

                ),

              ],
            ),

          ),
        );
      },
    );
  }
}
