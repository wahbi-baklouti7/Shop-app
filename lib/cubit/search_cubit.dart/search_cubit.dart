import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/search_cubit.dart/search_state.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

 static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;
  void SearchProduct({@required String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(url: searchUrl, token: token, data: {"text": text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SearchErrorState());
    });
  }
}

// SearchCubit():super (SearchInitialState());