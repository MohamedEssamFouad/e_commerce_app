import 'package:e_commerce_app/modules/screens/profileScreen/changePassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/shared/style/colors.dart';
import '../../../layout/layout_cubit/lay_out_cubit.dart';
import '../../../layout/layout_cubit/layout_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state) {},
      builder: (context,state){
        final cubit = BlocProvider.of<LayoutCubit>(context);
        if( cubit.userModel == null ) cubit.getUserData();
        return Scaffold(
            body: cubit.userModel != null ? Container(
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  CircleAvatar(
                    backgroundImage: NetworkImage(cubit.userModel!.image!),
                    radius: 45,
                  ),
                   SizedBox(height: 15.h,),
                  Text(cubit.userModel!.name!),
                   SizedBox(height: 10.h,),
                  Text(cubit.userModel!.email!),
                   SizedBox(height: 15.h,),
                  MaterialButton(
                    onPressed: ()
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>const ChangePassword()));
                    },
                    color: mainColor,
                    textColor: Colors.white,
                    child: const Text("Change Password"),
                  ),
                   SizedBox(height: 15.h,),
                  MaterialButton(
                    onPressed: ()
                    {
                    },
                    color: mainColor,
                    textColor: Colors.white,
                    child: const Text("Update Data"),
                  ),
                ],
              ),
            ) : const Center(
              child: CircularProgressIndicator(),
            )
        );
      },
    );
  }
}