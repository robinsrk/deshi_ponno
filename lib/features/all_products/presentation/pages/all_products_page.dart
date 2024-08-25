import 'dart:developer' as dev;

import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/all_products/presentation/bloc/product_list_cubit.dart';
import 'package:deshi_ponno/features/all_products/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("all_products"))),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductListLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  title: Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                      '${AppLocalizations.of(context).translate("brand")}: ${product.brand}'),
                  trailing: Hero(
                    tag: product.name,
                    child: Image.network(
                      product.imageUrl,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // If the image is loaded, return the image widget
                          return child;
                        } else {
                          // While the image is loading, show a spinner
                          return CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(product: product)));
                  },
                );
              },
            );
          } else if (state is ProductListError) {
            dev.log(state.message);
            return const Center(child: Text("Error loading products"));
          }
          return const Center(child: Text('No products available.'));
        },
      ),
    );
  }

  @override
  void initState() {
    context.read<ProductListCubit>().fetchAllProducts();
    super.initState();
  }
}
