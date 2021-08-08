import 'package:interview_0821_product_detail/app/core/utils/keys.dart';

class ProductExtraModel {
  int? id;
  String? name;
  int? min;
  int? max;
  List<ProductExtraItemModel>? items;

  ProductExtraModel({
    this.id,
    this.name,
    this.min,
    this.max,
    this.items,
  });

  ProductExtraModel.fromJson(Map<String, dynamic> json) {
    this.id = json[Keys.id];
    this.name = json[Keys.name];
    if (json[Keys.min] != null) {
      this.min = int.tryParse(json[Keys.min]);
    }
    if (json[Keys.min] != null) {
      this.max = int.tryParse(json[Keys.max]);
    }
  }
}

class ProductExtraItemModel {
  int? id;
  String? name;
  int? extraId;
  int? price;

  ProductExtraItemModel({this.id, this.name});

  ProductExtraItemModel.fromJson(Map<String, dynamic> json) {
    this.id = json[Keys.id];
    this.name = json[Keys.name];
    this.extraId = json[Keys.extraId];
    if (json[Keys.price] != null) {
      this.price = int.tryParse(json[Keys.price]);
    }
  }
}
