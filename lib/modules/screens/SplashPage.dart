import 'package:e_commerce_app/core/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Home.dart';
import 'auth_Screen/registerScreen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                APPvector.logo,
              ),
            ),
            
            Padding(
              padding:  EdgeInsets.only(bottom: 25.h),
              child: Text(
                'Developed by Mayuka',
                style: TextStyle(
                  fontSize: 20,
                    fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
