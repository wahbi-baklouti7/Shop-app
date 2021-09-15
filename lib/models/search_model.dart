class SearchModel {
  bool status;
  String message;
  SearchProductData data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data =
        json["data"] != null ? SearchProductData.fromJson(json["data"]) : null;
  }
}

class SearchProductData {
  int currentPage;

  List<SearchProduct> data = [];
  SearchProductData.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((element) {
      data.add(SearchProduct.fromJson(element));
    });
  }
}

class SearchProduct {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    name = json["name"];
    image = json["image"];
    description = json["description"];
  }
}
