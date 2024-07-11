import 'package:e_commerce_app/core/shared/constant/consts.dart';
import 'package:e_commerce_app/layout/layout_cubit/lay_out_cubit.dart';
import 'package:e_commerce_app/modules/screens/Home.dart';
import 'package:e_commerce_app/modules/screens/auth_Screen/auth_cubit.dart';
import 'package:e_commerce_app/modules/screens/profileScreen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/shared/network/local_network.dart';
import 'modules/screens/SplashPage.dart';
import 'modules/screens/auth_Screen/LoginScreen.dart';
import 'modules/screens/layoutScreen/layoutScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cachInitlization();
  token=await CacheNetwork.getCachedData(key: 'token');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>authCubit()),
      BlocProvider(create: (context)=>LayoutCubit()..GetBanner()..GetCat()..getProducts())
    ],
        child:  ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return  MaterialApp(
              debugShowCheckedModeBanner: false,



              home: token!=null&&token!=""? LayOutSCreen():LoginScreen(),


            );
          },
        ));
  }
}
