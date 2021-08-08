import 'package:get/get.dart';
import 'package:interview_0821_product_detail/app/data/model/product_detail_model.dart';
import 'package:interview_0821_product_detail/app/data/model/product_extra_model.dart';

import 'product_detail_repository.dart';

class ProductDetailController extends SuperController<ProductDetailModel> {
  final ProductDetailRepository repository;
  ProductDetailController(this.repository);

  final selectedQuantity = 1.obs;
  final selectedExtras = List<ProductExtraItemModel>.empty().obs;

  @override
  void onInit() {
    super.onInit();

    append(() => repository.getProductDetail);
  }

  int totalPrice() {
    int productPrice = selectedExtras.fold(
      value!.price!,
      (previousValue, element) => previousValue + element.price!,
    );
    return productPrice * selectedQuantity.value;
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
