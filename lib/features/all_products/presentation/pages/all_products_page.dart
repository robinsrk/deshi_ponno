import 'dart:developer' as dev;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/all_products/presentation/bloc/product_list_cubit.dart';
import 'package:deshi_ponno/features/all_products/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    final numberFormatter = GetIt.instance<NumberFormatterService>();
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
                  // trailing: Text(
                  //     "${AppLocalizations.of(context).translate("price")}: ${product.price.toStringAsFixed(2)} ৳"),
                  isThreeLine: true,
                  subtitle: Text(
                      '${AppLocalizations.of(context).translate("brand")}: ${product.brand}\n${AppLocalizations.of(context).translate("price")}: ${numberFormatter.formatCurrency(product.price, context)}'),
                  trailing: Hero(
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
