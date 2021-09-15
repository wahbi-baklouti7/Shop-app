import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ChangeFavoritesMode.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/shop_model.dart';
import 'package:shop_app/screens/shop_app/categories_screen.dart';
import 'package:shop_app/screens/shop_app/favorites_screen.dart';
import 'package:shop_app/screens/shop_app/products_screen.dart';
import 'package:shop_app/screens/shop_app/search_screen.dart';
import 'package:shop_app/screens/shop_app/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int current_index = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    current_index = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeData());
    DioHelper.getData(url: homeUrl, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.isFavorite});
      });
      // print(favorites.toString());
      emit(ShopSuccessHomeData());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeData());
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: categoriesUrl, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopCategoriesError());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites({int productId}) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesSuccess());
    DioHelper.postData(
            url: favoritesUrl, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      emit(ShopChangeFavoritesSuccess());
      getFavoritesData();
    }).catchError((onError) {
      emit(ShopChangeFavoritesError());
    });
  }

  FavoritesModel favoritesModel;
  void getFavoritesData() {
    DioHelper.getData(url: favoritesUrl, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopFavoritesError());
    });
  }

  LoginUserModel userModel;
  void getUserData() {
    emit(ShopLoadingUserData());
    DioHelper.getData(url: profileUrl, token: token).then((value) {
      userModel = LoginUserModel.fromJson(value.data);
      emit(ShopSuccessUserData(userModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUserData());
    });
  }

  
}
