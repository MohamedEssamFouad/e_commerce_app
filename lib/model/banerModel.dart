class BannerModel{
  int? id;
  String? url;

BannerModel.fromjson({required Map<String,dynamic>data}){
 id=data['id'];
 url=data['image'];
}
}