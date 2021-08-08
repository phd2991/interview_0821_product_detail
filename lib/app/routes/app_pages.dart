import 'package:get/get.dart';
import 'package:interview_0821_product_detail/app/modules/product_detail/product_detail_binding.dart';
import 'package:interview_0821_product_detail/app/modules/product_detail/product_detail_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
  ];
}
