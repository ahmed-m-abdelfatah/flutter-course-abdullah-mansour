class HomeModel {
  late bool status;
  late _HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = _HomeDataModel.fromJson(json['data']);
  }
}

class _HomeDataModel {
  List<_BannerModel> banners = [];
  List<ProductModel> products = [];

  _HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((banner) {
      banners.add(_BannerModel.fromJson(banner));
    });
    json['products'].forEach((product) {
      products.add(ProductModel.fromJson(product));
    });
  }
}

class _BannerModel {
  late int id;
  late String image;

  _BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
