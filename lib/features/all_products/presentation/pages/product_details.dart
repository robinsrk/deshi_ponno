import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductDetailsPage extends StatelessWidget {
  final CommonProduct product;

  const ProductDetailsPage({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final NumberFormatterService numberFormatter =
        GetIt.instance<NumberFormatterService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("product_details")),
      ),
      body: SingleChildScrollView(
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
                      height: 300,
                      progressIndicatorBuilder: (BuildContext context,
                              String url, DownloadProgress downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      errorWidget:
                          (BuildContext context, String url, Object error) =>
                              const Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              subtitle: Text(
                '${AppLocalizations.of(context).translate("brand")}: ${product.brand} \n${AppLocalizations.of(context).translate("origin")}: ${product.origin} \n${AppLocalizations.of(context).translate("price")}: ${numberFormatter.formatCurrency(product.price, context)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
