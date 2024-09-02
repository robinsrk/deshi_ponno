import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/home_page/domain/entities/product.dart';
import 'package:deshi_ponno/features/home_page/presentation/widgets/product_details_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProductHistory extends StatelessWidget {
  final Product product;
  const ProductHistory({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            title: Text(
          AppLocalizations.of(context).translate("recents"),
          style: Theme.of(context).textTheme.headlineSmall,
          textDirection: TextDirection.ltr,
        )),
        ListTile(
          title: Text(
            product.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
              '${AppLocalizations.of(context).translate("brand")}: ${product.brand}'),
          trailing: CachedNetworkImage(
            imageUrl: product.imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          onTap: () {
            _showProductDetailsBottomSheet(context, product);
          },
        )
      ],
    );
  }

  void _showProductDetailsBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ProductDetailsBottomSheet(product: product);
      },
    );
  }
}
