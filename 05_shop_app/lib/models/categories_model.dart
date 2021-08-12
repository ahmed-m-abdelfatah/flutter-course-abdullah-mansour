class CategoriesModel {
  late bool status;
  late _CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = _CategoriesDataModel.fromJson(json['data']);
  }
}

class _CategoriesDataModel {
  late int currentPage;
  List<DataModel> data = [];

  _CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
