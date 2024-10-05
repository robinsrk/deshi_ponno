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
        title: Text(
          AppLocalizations.of(context).translate("product_details"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
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
              trailing: Text(
                numberFormatter.formatCurrency(product.price, context),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("brand"),
                  ),
                  Text(product.brand)
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("origin"),
                  ),
                  Text(product.origin)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
