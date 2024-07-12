class UserModel{
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserModel({this.name,this.token,this.email,this.phone,this.image});
  UserModel.fromjson({required Map<String,dynamic>data}){
    name=data['name'];
    image=data['image'];
    phone=data['phone'];
    email=data['email'];
    token=data['token'];
  }
}