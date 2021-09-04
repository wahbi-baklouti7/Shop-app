import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shopapp/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/shop_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productBuild(
                  ShopCubit.get(context).homeModel,
                  ShopCubit.get(context).categoriesModel,
                  context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}

Widget productBuild(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage("${e.image}"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  height: 150.0,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  enableInfiniteScroll: true,
                  scrollDirection: Axis.horizontal,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  reverse: false,
                  viewportFraction: 1)),
          Text("Categories", style: TextStyle(fontSize: 24)),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoriesList(categoriesModel.data.data[index]),
                separatorBuilder: (context, index) => SizedBox(
                      width: 5,
                    ),
                itemCount: categoriesModel.data.data.length),
          ),
          SizedBox(
            height: 4,
          ),
          Text("New Products", style: TextStyle(fontSize: 26)),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.75,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              crossAxisCount: 2,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context)),
            ),
          )
        ],
      ),
    );

Widget buildGridProduct(ProductModel model, context) => Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
              // fit: BoxFit.cover,
            ),
            if (model.discount != 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
                child: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Discount",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  //product price
                  Text(
                    "${model.price.round()}",
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
                  if (model.discount != 0)
                    //old price
                    Text(
                      '${model.oldPrice.round()}',
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
                            .changeFavorites(productId: model.id);
                      },
                      icon: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]
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
    );

Widget buildCategoriesList(DataModel model) =>
    Stack(alignment: Alignment.bottomCenter, children: [
      Image(
        image: NetworkImage(model.image),
        height: 90,
        width: 90,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.6),
        width: 100,
        child: Text(
          model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      )
    ]);
