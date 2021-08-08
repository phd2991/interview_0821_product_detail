import 'package:get/get.dart';
import 'package:interview_0821_product_detail/app/data/provider/product_provider.dart';

import 'product_detail_controller.dart';
import 'product_detail_repository.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(
        ProductDetailRepository(ProductProvider()),
      ),
    );
  }
}
