import 'dart:convert';

import 'package:bloc/bloc.dart';
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


}