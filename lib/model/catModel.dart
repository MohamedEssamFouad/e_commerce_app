class CatModel{
  int? id;
  String? url;
  String? title;

  CatModel.fromjson({required Map<String,dynamic>data}){
    id=data['id'];
    url=data['image'];
    title=data['name'];

  }
}