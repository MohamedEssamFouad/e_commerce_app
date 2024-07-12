import 'package:e_commerce_app/model/ProductModel.dart';
import 'package:e_commerce_app/modules/widgets/SearchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/shared/style/colors.dart';
import '../../layout/layout_cubit/lay_out_cubit.dart';
import '../../layout/layout_cubit/layout_states.dart';
import '../widgets/bannerWidget.dart';
import '../widgets/productItem.dart';

class Home extends StatelessWidget {
  final pageController = PageController();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                SearchBarr(),
                SizedBox(height: 20.h),
                cubit.banners.isEmpty
                    ? Center(child: CupertinoActivityIndicator())
                    : BannerWidget(pageController: pageController),
                SizedBox(height: 15),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: cubit.banners.length,
                    axisDirection: Axis.horizontal,
                    effect: const SlideEffect(
                      spacing: 8.0,
                      radius: 25,
                      dotWidth: 16,
                      dotHeight: 16.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: secondColor,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(
                        color: secondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                cubit.cat.isEmpty
                    ? const Center(child: CupertinoActivityIndicator())
                    : SizedBox(
                  height: 70.h,
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 15.w);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    physics:const BouncingScrollPhysics(),
                    itemCount: cubit.cat.length,
                    itemBuilder: (context, index) {
                      return CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          cubit.banners[index].url!,
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(
                        color: secondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                cubit.product.isEmpty?Center(child: CupertinoActivityIndicator(),):
                prucductitems(),
              ],
            ),
          ),
        );
      },
    );
  }
}

