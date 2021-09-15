part of 'shop_cubit.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingHomeData extends ShopState {}

class ShopSuccessHomeData extends ShopState {}

class ShopErrorHomeData extends ShopState {}

class ShopCategoriesSuccess extends ShopState {}

class ShopCategoriesError extends ShopState {}

class ShopChangeFavoritesSuccess extends ShopState {}

class ShopChangeFavoritesError extends ShopState {}

class ShopFavoritesSuccess extends ShopState {}

class ShopFavoritesError extends ShopState {}

class ShopLoadingUserData extends ShopState {}

class ShopSuccessUserData extends ShopState {
  final LoginUserModel loginUserModel;
  ShopSuccessUserData(this.loginUserModel);
}
class ShopErrorUserData extends ShopState {}






