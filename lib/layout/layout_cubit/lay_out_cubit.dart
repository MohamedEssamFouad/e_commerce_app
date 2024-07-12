import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/shared/constant/consts.dart';
import 'package:e_commerce_app/model/user_model.dart';
import 'package:e_commerce_app/modules/screens/Home.dart';
import 'package:e_commerce_app/modules/screens/profileScreen/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../model/ProductModel.dart';
import '../../model/banerModel.dart';
import '../../model/catModel.dart';
import '../../modules/screens/Cart/cart.dart';
import '../../modules/screens/CategoreirsScreen/CategoreirsScreen.dart';
import '../../modules/screens/fav/fav.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(LayoutIntialState());

UserModel? userModel;
  void getUserData()async{
    emit(LayoutLoadingState());
    Response response=await http.get(
      Uri.parse("https://student.valuxapps.com/api/profile"),
      headers: {
        'authorization':token!,
        'lang':'en',
      }
    );
    var ResposedData=jsonDecode(response.body);
    if (ResposedData['status']==true)
    {
      userModel=UserModel.fromjson(data: ResposedData['data']);
      print("$ResposedData");
      emit(LayoutSucessState());
    }
    else
    {
     emit(LayoutFailedState(message: ResposedData['message'])) ;
    }

  }


  int bottomIndex=0;
  List<Widget>layoutScreen=[Home(),CategoreirsScreen(),Fav(),Cart(),ProfileScreen()];
  void changeIndex({required int index})
  {
     bottomIndex=index;
     emit(LayoutChangeBottom());
  }
List<BannerModel>banners=[];
void GetBanner()async{
  emit(BannerLoading());


  Response response =await http.get(
      Uri.parse('https://student.valuxapps.com/api/banners')
    );
    var responsedDataa=jsonDecode(response.body);
    print("producrs data is :$responsedDataa");
     if (responsedDataa['status']==true) {
       for(var item in responsedDataa['data'])
       {
       banners.add(BannerModel.fromjson(data: item));
       }
       emit(BannerSuccess());


     }  else{
       emit(BannerFailed());
     }


}


List<CatModel>cat=[];
void GetCat()async{
  Response response=await http.get(Uri.parse('https://student.valuxapps.com/api/categories'),
  
  
  );
  var responsedDa=jsonDecode(response.body);
  if (responsedDa['status']==true) {
    for(var item in responsedDa['data']['data']){
      cat.add(CatModel.fromjson(data: item));
      emit(CatSuccess());
    }
    
  }  else{
    emit(CatFailed());

  }
  
}


List<ProductModel>product=[];
void getProducts()async{
  Response response=await http.get(
    Uri.parse('https://student.valuxapps.com/api/home'),
    headers: {
      'Authorization':token!,
      'lang':'en',
    }
    
  );
  var reponsedD=jsonDecode(response.body);
  for(var item in reponsedD['data']['products'])
  {
    product.add(ProductModel.fromJson(data: item));
  }
  if (reponsedD['status']==true)
  {
    emit(ProductSuccess());
  }  else
  {
      emit(ProductFailed());
  }
}


List<ProductModel>filtered=[];
void filterdProducts({required String input})
{
 filtered= product.where((element) => element.name!.toLowerCase().startsWith(input.toLowerCase())).toList();
 emit(FilteredProductSuccess());
}

}