import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/models/search_model.dart';
import 'package:shoping/modules/search/cubit_search/search_states.dart';
import 'package:shoping/shared/components/constants.dart';
import 'package:shoping/shared/networks/endpoints.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String? text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text': text,
        },
    ).then((onValue){
      model = SearchModel.fromJson(onValue.data);
      emit(SearchSuccessState());
    }).catchError((onError){
      emit(SearchErrorState(onError.toString()));
    });
  }

}