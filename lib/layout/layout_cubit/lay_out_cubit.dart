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


  List<ProductModel>Favv=[];
  Set<String> favoritesID = {};

Future <void> GetFav()async{

  Response response=await http.get(
    Uri.parse('https://student.valuxapps.com/api/favorites'),
    headers: {
      'lang':'en',
      'Authorization':token!,
    }

  );
  var ResponsedB=jsonDecode(response.body);
      if (ResponsedB['status']==true) {
        for(var item in ResponsedB['data']['data'])
        {
        Favv.add(ProductModel.fromJson(data: item['product']));


        }
        print('token is ${token}');
        print('fav is ${Favv.length}');
        emit(GetFavSucced());
      }else{
        emit(GetFavFailed());
      }
}
  void addOrRemoveFromFavorites({required String productID}) async {
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          "lang" : "en",
          "Authorization" : token!
        },
        body:
        {
          "product_id" : productID
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      if( favoritesID.contains(productID) == true )
      {
        favoritesID.remove(productID);
      }
      else
      {

        favoritesID.add(productID);
      }
        await GetFav();
      emit(AddOrRemoveItemFromFavoritesSuccessState());
    }
    else
    {
      emit(FailedToAddOrRemoveItemFromFavoritesState());
    }
  }

List<ProductModel>cart=[];
Set <String> cartsId={};
int totalP=0;
Future<void> GetCard()async{
  
  cart.clear();
  Response response=await http.get(
    Uri.parse('https://student.valuxapps.com/api/carts'),
    headers: {
      "lang" : "en",
      "Authorization" : token!
    },

  );
  var ResponsedDd=jsonDecode(response.body);
  totalP=ResponsedDd['data']['total'].toInt();
  if (ResponsedDd['status']==true)
  {
    for(var item in ResponsedDd['data']['cart_items']){
      cartsId.add(item['product']['id'].toString());
      cart.add(ProductModel.fromJson(data: item['product']));
    }
    print('ssss ${cart.length}');
    emit(SuccessGetCart());
  }
  else
  {
    emit(FailedGetCart());
  }
}

void addOrRemoveFromCard ({required String id})async{
  Response response =await http.post(Uri.parse('https://student.valuxapps.com/api/carts'),

  headers: {

    "Authorization" : token!,
    'lang':'en'

  },
    body: {
    'product_id':id
    }
    
  );
  var ResponseBody=jsonDecode(response.body);
  if (ResponseBody['status']==true) {
    cartsId.contains(id)==true?cartsId.remove(id):cartsId.add(id);
    GetCat();
    emit(SuccessGetCart());
  }
  else{
    emit(FFailedAddToCard());
  }

}
}