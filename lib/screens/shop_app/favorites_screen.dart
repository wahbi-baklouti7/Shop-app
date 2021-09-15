import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shopapp/shop_cubit.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildItems(
                  ShopCubit.get(context).favoritesModel.data.data[index].products,context,isfavorite: true),
              separatorBuilder: (context, index) => Divider(
                    height: 10,
                    color: Colors.grey,
                    endIndent:1 ,
                  ),
              itemCount: ShopCubit.get(context).favoritesModel.data.data.length);
        });
  }

 
}
