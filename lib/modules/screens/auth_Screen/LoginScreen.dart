import 'package:e_commerce_app/core/shared/style/colors.dart';
import 'package:e_commerce_app/modules/screens/Home.dart';
import 'package:e_commerce_app/modules/screens/auth_Screen/auth_cubit.dart';
import 'package:e_commerce_app/modules/screens/auth_Screen/auth_states.dart';
import 'package:e_commerce_app/modules/screens/auth_Screen/registerScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/shared/constant/formfield.dart';
import '../layoutScreen/layoutScreen.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  TextEditingController controller1=TextEditingController();
   TextEditingController controller2=TextEditingController();
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

   body: Stack(
     children: [
       Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/auth_background.png'),fit: BoxFit.fill
           )
         ),
       ),
       Align(
         alignment: Alignment.center,
         child: Container(
           height: 400.h,
             child: Text('Login to continue process',style: TextStyle(
               fontSize: 20.sp,
               fontWeight: FontWeight.bold,
               color: Colors.white,
             ),)),
       ),
       Align(
         alignment: Alignment.bottomCenter,
         child: Container(
          height: 450.h,
           width: double.infinity,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
             color: thirdColor,

           ),
           child:Padding(
             padding:  EdgeInsets.symmetric(vertical: 50.h,horizontal: 25.w),
             child: Form(
               key: formKey,
               child: BlocConsumer<authCubit,AuthStates>(
                 listener:(context,state){
                   if (state is LoginSuccess) {
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context)=>LayOutSCreen()));
                   }
                   if (state is LoginFailed) {
                     showDialog(context: context, builder: (context)=>AlertDialog(
                       content: Text(
                         state.Message,
                         style: TextStyle(
                           color: Colors.white,
                         ),

                       ),
                       backgroundColor: Colors.red,
                     ));
                   }

                 } ,
                 builder:(context,state){
                   return Column(

                     children: [
                       Text('Login',style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20.sp,
                       ),),
                       TextFieldd(

                         controller: controller1,
                         hinttitle: 'Email',

                       ),
                       SizedBox(height: 20.h,),
                       TextFieldd(
                         controller: controller2,
                         hinttitle: 'Password',
                         isSecured: true,

                       ),
                       SizedBox(height: 10.h,),
                       MaterialButton(onPressed: (){
                         if (formKey.currentState!.validate()==true) {
                           BlocProvider.of<authCubit>(context).Login(email: controller1.text, password: controller2.text);

                         }
                       },
                         color: mainColor,
                         textColor: Colors.white,
                         minWidth: double.infinity,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(4)
                         ),

                         padding: EdgeInsets.symmetric(vertical: 15),
                         child: Text(
                           state is LoginLoading?'Loading':'login',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 15
                           ),
                         ),


                       ),
                       Spacer(),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:
                         [
                           const Text('Don\'t have an account? ',style: TextStyle(color: Colors.black)),
                           SizedBox(width: 4,),
                           InkWell(
                             onTap: ()
                             {
                               Navigator.push(context, MaterialPageRoute(builder: (context) =>RegisterScreen()));
                             },
                             child: const Text('Create one',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
                           )
                         ],
                       )


                   ],
                   );
                 } ,
               ),
             ),
           ) ,

           ),
         ),

     ],
   ),
    );
  }
}
