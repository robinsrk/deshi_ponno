import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final numberFormatter = GetIt.instance<NumberFormatterService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: product.name,
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
                ),
              ],
            ),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
                '${AppLocalizations.of(context).translate("brand")}: ${product.brand}'),
            const SizedBox(height: 8),
            Text(
                '${AppLocalizations.of(context).translate("origin")}: ${product.origin}'),
            const SizedBox(height: 8),
            Text(
                '${AppLocalizations.of(context).translate("price")}: ${numberFormatter.formatCurrency(product.price, context)}')
          ],
        ),
      ),
    );
  }
}
