import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shopapp/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => categoriesList(
                  ShopCubit.get(context).categoriesModel.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
              itemCount:
                  ShopCubit.get(context).categoriesModel.data.data.length);
        });
  }

  Widget categoriesList(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 22),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward,
            size: 30,
          ),
        ],
      ),
    );
  }
}
