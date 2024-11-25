class ChangeFavoriteModel{

  bool status = false;
  String? message;

  ChangeFavoriteModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}