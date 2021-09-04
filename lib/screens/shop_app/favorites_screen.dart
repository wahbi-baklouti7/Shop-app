import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shopapp/shop_cubit.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildFavoriteItems(
                  ShopCubit.get(context).favoritesModel.data.data[index],context),
              separatorBuilder: (context, index) => Divider(
                    height: 10,
                    color: Colors.grey,
                    endIndent:1 ,
                  ),
              itemCount: ShopCubit.get(context).favoritesModel.data.data.length);
        });
  }

  Widget buildFavoriteItems(ProductData model,context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Image(
                image: NetworkImage("${model.products.image}"),
                width: 150,
                height: 150,
                // fit: BoxFit.cover,
              ),
              if (model.products.discount != 0)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "Discount",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.products.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                Spacer(),
                Row(
                  children: [
                    //product price
                    Text(
                      "${model.products.price.toString()}",
                      maxLines: 2,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    if (model.products.discount != 0)
                      //old price
                      Text(
                        '${model.products.oldPrice.toString()}',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(productId: model.products.id);
                        },
                        icon: CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.products.id]
                                    ? primaryColor
                                    : Colors.grey,
                            child: Icon(Icons.favorite_border,
                                color: Colors.white))),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
