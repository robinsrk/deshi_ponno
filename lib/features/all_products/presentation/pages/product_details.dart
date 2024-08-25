import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
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
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // If the image is loaded, return the image widget
                          return child;
                        } else {
                          // While the image is loading, show a spinner
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        // Handle errors in image loading
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
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
            // Add other product details as needed
            const SizedBox(height: 16),
            Text(
                '${AppLocalizations.of(context).translate("price")}: ${product.price}')
          ],
        ),
      ),
    );
  }
}
