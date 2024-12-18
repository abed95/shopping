import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/models/categories_model.dart';
import 'package:shoping/models/change_favorite_mode.dart';
import 'package:shoping/models/favorite_model.dart';
import 'package:shoping/models/home_model.dart';
import 'package:shoping/models/login_model.dart';
import 'package:shoping/modules/categories/categories_screen.dart';
import 'package:shoping/modules/favorites/favorites_screen.dart';
import 'package:shoping/modules/products/products_screen.dart';
import 'package:shoping/modules/setting/setting_screen.dart';
import 'package:shoping/shared/components/constants.dart';
import 'package:shoping/shared/networks/endpoints.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';
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
  Map<int?, bool?> favorite = {};
  void getHomeData() {
    emit(ProductsLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((onValue) {
      homeModel = HomeModel.fromJson(onValue.data);
      //to fill all favorite product
      homeModel!.data!.products!.forEach((element) {
        favorite.addAll({
          element.id : element.favorites,
        });
      });
      print('getHomeData favorite data ==>${favorite.toString()}');
      emit(ProductsSuccessState());
    }).catchError((onError) {
      emit(ProductsErrorState(onError.toString()));
      print('print favorite Error ==> ${onError.toString()}');
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
      print('getCategoriesData Error==> ${onError.toString()}');
    });
  }

  //Change Favorites
  ChangeFavoriteModel? changeFavoriteModel;
  Set<int?> loadingFavorites = {};
  void changeFavorites(int? productId) {
    favorite[productId] = !favorite[productId]!;
    loadingFavorites.add(productId); // Start loading
    emit(ChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((onValue) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(onValue.data);
      if (!changeFavoriteModel!.status) {
        favorite[productId] = !favorite[productId]!;
      }else{
        getFavoriteData();
      }
      loadingFavorites.remove(productId); // Stop loading
      print('changeFavorites 95 then ==> ${onValue.data}');
      emit(ChangeFavoriteSuccessState(changeFavoriteModel));
    }).catchError((onError) {
      favorite[productId] = !favorite[productId]!;
      loadingFavorites.remove(productId); // Stop loading
      emit(ChangeFavoriteErrorState(onError));
      print('changeFavorites 100 Error == > ${onError.toString()}');
    });
  }

  //Get Favorites
  FavoriteModel? favoriteModel;
  void getFavoriteData() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((onValue) {
      favoriteModel = FavoriteModel.fromJson(onValue.data);
      emit(GetFavoritesSuccessState());
      print('getFavoriteData ');
    }).catchError((onError) {
      emit(GetFavoritesErrorState(onError.toString()));
      print('GetFavoritesErrorState 116 ==> ${onError.toString()}');
    });
  }


  LoginModel? userModel;
  void getUserData() {
    emit(GetUserLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData(key: 'token'),
    ).then((onValue) {
      userModel = LoginModel.fromJson(onValue.data);
      //print('getUserData 129 then ==> ${userModel.data}');
      emit(GetUserSuccessState(userModel));
      print('getUserData 132 ${onValue.data}');
      print(token);
    }).catchError((onError) {
      emit(GetUserErrorState(onError.toString()));
      print('getUserData 133 Error ==> ${onError.toString()}');
    });
  }

  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
}) {
    emit(UpdateUserLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:{
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((onValue) {
      userModel = LoginModel.fromJson(onValue.data);
      print('inside updateUserData then 153 $userModel');
      emit(UpdateUserSuccessState(userModel));
    }).catchError((onError) {
      emit(UpdateUserErrorState(onError.toString()));
      print('updateUserData ${onError.toString()}');
    });
  }

//Change the mode theme
  bool isDarkCubit = false;
  void changeThemeMode({bool? fromShared}){
    if(fromShared != null){
      isDarkCubit = !fromShared;
      CacheHelper.saveData(key: 'isDark', value: isDarkCubit).then((onValue){
        emit(ChangeThemeModeSuccessState());
      }).catchError((onError){
        emit(ChangeThemeModeErrorState());
      });
    }else{
      isDarkCubit = !isDarkCubit;
      CacheHelper.saveData(key: 'isDark', value: isDarkCubit).then((onValue){
        emit(ChangeThemeModeSuccessState());
      }).catchError((onError){
        emit(ChangeThemeModeErrorState());
      });
    }
  }
}
