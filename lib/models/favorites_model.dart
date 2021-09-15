class FavoritesModel {
  bool status;
  FavoritesData data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] != null ? FavoritesData.fromJson(json["data"]) : null;
  }
}

class FavoritesData {
  int currentPage;
  List<ProductData> data = [];

  FavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((element) {
      data.add(ProductData.fromJson(element));
    });
  }
}

class ProductData {
  int id;
  FavoritesProductData products;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    products = json["product"] != null
        ? FavoritesProductData.fromJson(json["product"])
        : null;
  }
}

class FavoritesProductData {
  int id;
  dynamic price;
  String name;
  dynamic oldPrice;
  int discount;
  String image;
  String description;

  FavoritesProductData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];

    name = json["name"];
    image = json["image"];

    description = json["description"];
  }
}
