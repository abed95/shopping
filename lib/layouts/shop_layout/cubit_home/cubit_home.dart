
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/modules/login_screen/login_screen.dart';
import 'package:shoping/shared/components/components.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  void Logout(String key,context) {
    CacheHelper.removeData(key: key).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
        );
      }
    });
  }

}
