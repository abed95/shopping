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
class CategoriesLoadingState extends HomeStates{}
class CategoriesSuccessState extends HomeStates{}
class CategoriesErrorState extends HomeStates{
  final String error;
  CategoriesErrorState(this.error);
}


