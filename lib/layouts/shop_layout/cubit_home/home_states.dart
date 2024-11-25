import 'package:shoping/models/change_favorite_mode.dart';

abstract class HomeStates{}
class HomeInitialState extends HomeStates{}

// Bottom Nav States
class HomeBottomNavState extends HomeStates{}
class ChangeBottomNavState extends HomeStates{}

//Home States
class ProductsLoadingState extends HomeStates{}
class ProductsSuccessState extends HomeStates{}
class ProductsErrorState extends HomeStates{
  final String error;
  ProductsErrorState(this.error);
}

//Categories States
class CategoriesSuccessState extends HomeStates{}
class CategoriesErrorState extends HomeStates {
  final String error;
  CategoriesErrorState(this.error);
}

// Change Favorite States
class ChangeFavoriteSuccessState extends HomeStates{
  final ChangeFavoriteModel? model;
  ChangeFavoriteSuccessState(this.model);
}
class ChangeFavoriteState extends HomeStates{}
class ChangeFavoriteErrorState extends HomeStates{
  final String error;
  ChangeFavoriteErrorState(this.error);
}

//Get Favorites States
class GetFavoritesSuccessState extends HomeStates{}
class GetFavoritesLoadingState extends HomeStates{}
class GetFavoritesErrorState extends HomeStates {
  final String error;
  GetFavoritesErrorState(this.error);
}


