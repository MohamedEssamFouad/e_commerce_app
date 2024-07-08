import 'package:e_commerce_app/core/shared/style/colors.dart';
import 'package:e_commerce_app/modules/screens/Home.dart';
import 'package:e_commerce_app/modules/screens/auth_Screen/auth_cubit.dart';
import 'package:e_commerce_app/modules/screens/auth_Screen/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller1=TextEditingController();
    TextEditingController controller2=TextEditingController();
    TextEditingController controller3=TextEditingController();
    TextEditingController controller4=TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();


    return BlocProvider(



        create: (context)=>authCubit(),
    child: BlocConsumer<authCubit,AuthStates>(
      listener:(context,state){

        if (state is RegisterSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>Home()));
        }else if (state is RegisterfailedState) {
          showDialog(context: context, builder: (context)=>AlertDialog(
            content: Text(
              state.message,
              style: TextStyle(
                color: Colors.white,
              ),

            ),
            backgroundColor: Colors.red,
          ));
        }
      } ,
      builder: (context,state){
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,

                      ),
                    ),
                    _TextField(hinttitle: 'User Name',controller:controller1, ),
                    SizedBox(height: 25.h,),
                    _TextField(hinttitle: 'Email',controller:controller2, ),
                    SizedBox(height: 25.h,),

                    _TextField(hinttitle: 'Phone',controller:controller3, ),
                    SizedBox(height: 25.h,),

                    _TextField(hinttitle: 'Password',controller:controller4, isSecured: true),
                    SizedBox(height: 25.h,),
                     MaterialButton(onPressed: (){
if (formKey.currentState!.validate()) {
  BlocProvider.of<authCubit>(context).register(name: controller1.text, email: controller2.text, password:controller4.text, phone: controller3.text);
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
                         state is RegisterLoadingState?'Loading':'Register',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 15
                         ),
                       ),


                     ),

                  ],
                ),
              ),
            ),
          ),

        );
      },
    ),);
  }
  Widget _TextField({bool? isSecured,required String hinttitle , required TextEditingController controller }){
    return TextFormField(
      obscureText: isSecured??false,
      controller: controller,
      validator: (input){
        if(controller.text.isEmpty){
          return '$hinttitle must not be empty';
        }else{
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hinttitle,
        border: OutlineInputBorder(

        )
      ),
    );
  }
}
