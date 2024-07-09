import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget TextFieldd({bool? isSecured,required String hinttitle , required TextEditingController controller }){
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
