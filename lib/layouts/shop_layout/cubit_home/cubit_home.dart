import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/models/categories_model.dart';
import 'package:shoping/models/home_model.dart';
import 'package:shoping/modules/categories/categories_screen.dart';
import 'package:shoping/modules/favorites/favorites_screen.dart';
import 'package:shoping/modules/products/products_screen.dart';
import 'package:shoping/modules/setting/setting_screen.dart';
import 'package:shoping/shared/components/constants.dart';
import 'package:shoping/shared/networks/endpoints.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  //constructor match the super
  HomeCubit() : super(HomeInitialState());

  // object once time from the home cubit to use it to reach the methods
  static HomeCubit get(context) => BlocProvider.of(context);

  //For Bottom Nav Changing
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  //For Products home data
  HomeModel? homeModel;

  void getHomeData() {
    emit(ProductsLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((onValue) {
      homeModel = HomeModel.fromJson(onValue.data);
      print(homeModel!.status);
      printFullText(homeModel!.data!.banners?[4].image??'');
      emit(ProductsSuccessState());
    }).catchError((onError) {
      emit(ProductsErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  //For Categories Data
  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((onValue) {
      categoriesModel = CategoriesModel.fromJson(onValue.data);
      emit(CategoriesSuccessState());
    }).catchError((onError) {
      emit(CategoriesErrorState(onError.toString()));
      print(onError.toString());
    });
  }


}
