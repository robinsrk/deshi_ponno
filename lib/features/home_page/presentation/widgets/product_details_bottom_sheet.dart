import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final CommonProduct product;

  const ProductDetailsBottomSheet({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormatter = GetIt.instance<NumberFormatterService>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate("product_details"),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Wrap(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(numberFormatter.formatCurrency(product.price, context),
                    style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${AppLocalizations.of(context).translate("brand")}: ${product.brand}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).translate("brand")),
                Text(product.brand),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).translate("origin")),
                Text(product.origin),
              ],
            ),
            Text(
              "${AppLocalizations.of(context).translate("price")}: ${numberFormatter.formatCurrency(product.price, context)}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
