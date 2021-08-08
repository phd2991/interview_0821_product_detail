import 'package:interview_0821_product_detail/app/data/model/product_detail_model.dart';
import 'package:interview_0821_product_detail/app/data/provider/product_provider.dart';

class ProductDetailRepository {
  final ProductProvider productProvider;

  ProductDetailRepository(this.productProvider);

  Future<ProductDetailModel> getProductDetail() async {
    final response = await productProvider.getProductDetail();
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body!;
    }
  }
}
