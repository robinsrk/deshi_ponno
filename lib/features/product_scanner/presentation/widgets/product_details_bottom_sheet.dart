import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final Product product;

  const ProductDetailsBottomSheet({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
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
                  child: Image.network(
                    product.image_url,
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
              ],
            ),
            Text(
              "${AppLocalizations.of(context).translate("name")}: ${product.name}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "${AppLocalizations.of(context).translate("brand")}: ${product.brand}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
