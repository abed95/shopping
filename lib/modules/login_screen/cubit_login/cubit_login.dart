import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/modules/login_screen/cubit_login/states_login.dart';
import 'package:shoping/shared/networks/endpoints.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

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
          emit(ShopLoginSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye : Icons.remove_red_eye_outlined;

    emit(ShopChangePasswordVisibilityState());


  }

}