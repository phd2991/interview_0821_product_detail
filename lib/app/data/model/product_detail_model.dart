import 'package:interview_0821_product_detail/app/core/utils/keys.dart';
import 'package:interview_0821_product_detail/app/data/model/product_extra_model.dart';

class ProductDetailModel {
  int? id;
  String? name;
  int? price;
  String? description;
  String? image;
  List<ProductExtraModel>? extras;

  ProductDetailModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.image,
    this.extras,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    this.id = json[Keys.id];
    this.name = json[Keys.name];
    this.price = json[Keys.price];
    this.description = json[Keys.description];
    this.image = json[Keys.images][Keys.fullSize];
    this.extras = (json[Keys.extras] as List)
        .map((e) => ProductExtraModel.fromJson(e))
        .toList();
    (json[Keys.extraItems] as List).forEach((element) {
      final item = ProductExtraItemModel.fromJson(element);

      final extra = this.extras!.firstWhere((e) => e.id == item.extraId);
      if (extra.items == null) {
        extra.items = [];
      }
      extra.items!.add(item);
    });
  }
}
