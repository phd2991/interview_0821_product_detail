import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_0821_product_detail/app/core/utils/strings.dart';
import 'package:interview_0821_product_detail/app/data/model/product_detail_model.dart';
import 'package:interview_0821_product_detail/app/data/model/product_extra_model.dart';
import 'package:interview_0821_product_detail/app/global_widgets/numeric_step_button.dart';

import 'product_detail_controller.dart';
import 'package:interview_0821_product_detail/app/core/utils/helpers.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: controller.obx(
          (state) => _buildPage(context, state!),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, ProductDetailModel model) {
    return CustomScrollView(
      slivers: [
        _builAppBar(context, model),
        _buildInfoSection(context, model),
        SliverToBoxAdapter(child: Divider(height: 1)),
        _buildQuantitySection(context, model),
        if (model.extras != null)
          ...model.extras!.map((e) => _buildExtra(context, e)).toList(),
        _buildAddButton(context, model),
      ],
    );
  }

  Widget _builAppBar(BuildContext context, ProductDetailModel model) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      leading: Center(
        child: ElevatedButton(
          child: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            visualDensity: VisualDensity.compact,
            primary: Colors.white,
            onPrimary: Colors.grey,
            elevation: 0,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
          background: model.image != null
              ? Image.network(model.image!, fit: BoxFit.cover)
              : Icon(Icons.image)),
    );
  }

  Widget _buildInfoSection(BuildContext context, ProductDetailModel model) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.name ?? '',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 12),
            Text(
              model.description ?? '',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySection(BuildContext context, ProductDetailModel model) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            SizedBox(width: 8),
            Expanded(child: Text('฿${model.price}')),
            NumericStepButton(
              minValue: 1,
              maxValue: 1000,
              initialValue: 1,
              onChanged: (val) => controller.selectedQuantity.value = val,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildExtra(BuildContext context, ProductExtraModel modelExtra) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Divider(height: 1),
        _buildExtraHeader(context, modelExtra),
        if (modelExtra.min! > 0) _buildExtraSubHeader(context, modelExtra),
        ...modelExtra.items!
            .map((e) {
              if (modelExtra.min! == 1 && modelExtra.max! == 1)
                return _buildSingleChoiceExtraItem(context, e);
              else
                return _buildMultipleChoiceExtraItem(
                    context, modelExtra.max!, e);
            })
            .toList()
            .addGap(gap: Divider(height: 1)),
      ]),
    );
  }

  Widget _buildExtraHeader(BuildContext context, ProductExtraModel modelExtra) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      child: RichText(
        text: TextSpan(
          text: (modelExtra.name ?? '').toUpperCase(),
          children: [
            if (modelExtra.min != null && modelExtra.min! > 0)
              TextSpan(
                text: Strings.required,
                style: TextStyle(color: Colors.grey),
              )
          ],
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }

  Widget _buildExtraSubHeader(
      BuildContext context, ProductExtraModel modelExtra) {
    String text = '';
    if (modelExtra.min == modelExtra.max)
      text = modelExtra.min == 1
          ? Strings.requiredSingleItem
          : Strings.requiredPluralItem.interpolate([modelExtra.min]);
    else
      text = Strings.requiredRangedItem
          .interpolate([modelExtra.min, modelExtra.max]);

    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSingleChoiceExtraItem(
      BuildContext context, ProductExtraItemModel item) {
    return Obx(() => RadioListTile<int?>(
          value: item.id,
          groupValue: controller.selectedExtras.length == 0
              ? null
              : controller.selectedExtras.first.id,
          title: RichText(
            text: TextSpan(
              text: item.name ?? '',
              children: [
                if (item.price != null && item.price! > 0)
                  TextSpan(
                    text: '(฿${item.price})',
                    style: TextStyle(color: Colors.grey),
                  )
              ],
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: (_) {
            controller.selectedExtras.clear();
            controller.selectedExtras.add(item);
          },
        ));
  }

  Widget _buildMultipleChoiceExtraItem(
      BuildContext context, int maxValue, ProductExtraItemModel item) {
    return Obx(() => CheckboxListTile(
          value: controller.selectedExtras.contains(item),
          title: RichText(
            text: TextSpan(
              text: item.name ?? '',
              children: [
                if (item.price != null && item.price! > 0)
                  TextSpan(
                    text: '(฿${item.price})',
                    style: TextStyle(color: Colors.grey),
                  )
              ],
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: controller.selectedExtras.contains(item)
              ? (_) => controller.selectedExtras.remove(item)
              : controller.selectedExtras.length < maxValue
                  ? (_) => controller.selectedExtras.add(item)
                  : null,
        ));
  }

  Widget _buildAddButton(BuildContext context, ProductDetailModel model) {
    return Obx(() => SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: ElevatedButton(
              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  Expanded(
                    child: Text(
                      Strings.addToCart
                          .interpolate([controller.selectedQuantity]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text('(฿${controller.totalPrice()})'),
                ],
              ),
              onPressed: isAddButtonEnable(model)
                  ? () => Get.showSnackbar(GetBar(
                        message: Strings.addToCart
                            .interpolate([controller.selectedQuantity]),
                      ))
                  : null,
            ),
          ),
        ));
  }

  bool isAddButtonEnable(ProductDetailModel model) {
    if (model.extras == null) {
      return true;
    }
    for (ProductExtraModel extra in model.extras!) {
      final selectedItems =
          controller.selectedExtras.where((e) => e.extraId == extra.id);
      if (selectedItems.length < extra.min!) return false;
    }
    return true;
  }
}
