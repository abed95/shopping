import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/models/login_model.dart';
import 'package:shoping/modules/login_screen/cubit_login/states_login.dart';
import 'package:shoping/shared/networks/endpoints.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }).then((value){
          print(value.data);
          loginModel = LoginModel.fromJson(value.data);
          print(loginModel?.status);
          print(loginModel?.message);
          print(loginModel?.data?.token);
          emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  //Change Password Visibility
  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye : Icons.remove_red_eye_outlined;
    emit(ShopChangePasswordVisibilityState());
  }

}