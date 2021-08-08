import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:interview_0821_product_detail/app/core/utils/api_constants.dart';
import 'package:interview_0821_product_detail/app/data/model/product_detail_model.dart';

class ProductProvider extends GetConnect {
  Future<Response<ProductDetailModel>> getProductDetail() => get(
        Api.urlProductDetail,
        decoder: (data) => ProductDetailModel.fromJson(jsonDecode(data)),
      );
}
