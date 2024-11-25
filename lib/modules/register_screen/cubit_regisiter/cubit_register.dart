

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/modules/register_screen/cubit_regisiter/register_states.dart';
import 'package:shoping/shared/networks/endpoints.dart';
import '../../../models/login_model.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone': phone,
        }).then((value){
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel?.status);
      print(loginModel?.message);
      print(loginModel?.data?.token);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  //Change Password Visibility
  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye : Icons.remove_red_eye_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

}