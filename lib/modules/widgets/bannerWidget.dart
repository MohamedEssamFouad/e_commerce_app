import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../layout/layout_cubit/lay_out_cubit.dart';

class BannerWidget extends StatelessWidget {
  final PageController pageController;

  BannerWidget({required this.pageController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return SizedBox(
      height: 125.h,
      width: double.infinity,
      child: PageView.builder(
        controller: pageController, // Use the passed pageController
        physics: BouncingScrollPhysics(),
        itemCount: cubit.banners.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 12),
            child: Image.network(
              cubit.banners[index].url!,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
