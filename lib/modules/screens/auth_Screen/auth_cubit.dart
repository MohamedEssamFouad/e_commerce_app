import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'auth_states.dart';

class authCubit extends Cubit<AuthStates>{
  authCubit() : super(AuthInitialState());



  void register({required String name,required String email,required String password,required String phone})async{
    emit(RegisterLoadingState());
  Response response= await http.post(
      Uri.parse('https://student.valuxapps.com/api/register'),
      body: {
        'name':name,
        'email' : email,
        'password':password,
        'phone':phone,




      },
    headers: {
        'lang':'en'
    }


    );
  var responsebody=jsonDecode(response.body);
  if(responsebody['status']==true){
    emit(RegisterSuccessState());

  }else{
emit(RegisterfailedState(message: responsebody['message']));
  }



  }
  void Login({required String email,required String password})async{
    emit(LoginLoading());
    try{
      Response response = await http.post(Uri.parse('https://student.valuxapps.com/api/login'),

      body: {
        'email':email,
        'password': password
      },
        headers: {
          'lang':'en'

        }
      );
     if(response.statusCode==200){
       var Data=jsonDecode(response.body);
       if (Data['status']==true) {
         debugPrint("user login success his data is : ${Data['message']}");
         emit(LoginSuccess());
       }
       else
       {

       debugPrint("user login failed his data is : ${Data['message']}");

       emit(LoginFailed(Message: Data['message']));


       }
     }


    }catch(e){
        emit(LoginFailed(Message: e.toString()));
    }
  }






}