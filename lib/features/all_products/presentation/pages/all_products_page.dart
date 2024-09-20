import 'dart:developer' as dev;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/all_products/domain/entities/product_filter.dart';
import 'package:deshi_ponno/features/all_products/presentation/bloc/product_list_cubit.dart';
import 'package:deshi_ponno/features/all_products/presentation/pages/product_details.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductFilter _filter = ProductFilter(
      origin: 'Bangladesh', minPrice: 0, maxPrice: double.infinity, brand: '');

  @override
  Widget build(BuildContext context) {
    final numberFormatter = GetIt.instance<NumberFormatterService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("all_products")),
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductListLoaded) {
            final origins = state.products
                .map((product) => product.origin)
                .toSet()
                .toList();
            final brands =
                state.products.map((product) => product.brand).toSet().toList();
            final filteredProducts = _applyFilters(state.products);
            return Column(
              children: [
                _buildFilterRow(origins, brands),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ListTile(
                        title: Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        isThreeLine: true,
                        subtitle: Text(
                          '${AppLocalizations.of(context).translate("brand")}: ${product.brand}\n${AppLocalizations.of(context).translate("price")}: ${numberFormatter.formatCurrency(product.price, context)}',
                        ),
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
                  ),
                ),
              ],
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
    super.initState();
  }

  List<CommonProduct> _applyFilters(List<CommonProduct> products) {
    return products.where((product) {
      final matchesOrigin =
          _filter.origin.isEmpty || product.origin == _filter.origin;
      final matchesPrice = product.price >= _filter.minPrice &&
          product.price <= _filter.maxPrice;
      final matchesBrand =
          _filter.brand.isEmpty || product.brand == _filter.brand;
      return matchesOrigin && matchesPrice && matchesBrand;
    }).toList();
  }

  Widget _buildDropdownChip(BuildContext context, String selectedValue,
      String hint, List<String> items, ValueChanged<String?> onChanged) {
    return InkWell(
      onTap: () async {
        final selectedItem = await showModalBottomSheet<String>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Wrap(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).translate("all")),
                  onTap: () {
                    Navigator.pop(context, "All");
                  },
                ),
                ...items.map((item) {
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      Navigator.pop(context, item);
                    },
                  );
                })
              ],
            );
          },
        );
        if (selectedItem != null) {
          onChanged(selectedItem == "All" ? null : selectedItem);
        }
      },
      child: Chip(
        label: Text(selectedValue.isEmpty ? hint : selectedValue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  Widget _buildFilterRow(List<String> origins, List<String> brands) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              _buildDropdownChip(
                context,
                _filter.origin,
                AppLocalizations.of(context).translate("origin"),
                origins,
                (value) {
                  setState(() {
                    _filter = ProductFilter(
                      origin: value ?? '',
                      minPrice: _filter.minPrice,
                      maxPrice: _filter.maxPrice,
                      brand: _filter.brand,
                    );
                  });
                },
              ),
              const SizedBox(width: 8),
              _buildDropdownChip(
                context,
                _filter.brand,
                AppLocalizations.of(context).translate("brand"),
                brands,
                (value) {
                  setState(() {
                    _filter = ProductFilter(
                      origin: _filter.origin,
                      minPrice: _filter.minPrice,
                      maxPrice: _filter.maxPrice,
                      brand: value ?? "",
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
