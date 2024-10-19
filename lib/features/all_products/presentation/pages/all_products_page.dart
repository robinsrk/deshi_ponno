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
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:super_context_menu/super_context_menu.dart';

class ProductListPage extends StatefulWidget {
  final String? categoryName;
  final String? brandName;

  const ProductListPage(
      {super.key, required this.categoryName, required this.brandName});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductFilter _filter = ProductFilter(
    origin: "Bangladesh",
    minPrice: 0,
    maxPrice: double.infinity,
    brand: "",
    name: "",
    category: "",
  );

  bool _isAdLoaded = false;
  bool _isSearching = false;
  late BannerAd bannerAd;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final numberFormatter = GetIt.instance<NumberFormatterService>();
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate("search"),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                onChanged: (query) {
                  setState(() {
                    _filter = ProductFilter(
                      origin: _filter.origin,
                      minPrice: _filter.minPrice,
                      maxPrice: _filter.maxPrice,
                      brand: _filter.brand,
                      name: query,
                      category: _filter.category,
                    );
                  });
                },
              )
            : Text(AppLocalizations.of(context).translate("all_products")),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _filter = ProductFilter(
                    origin: _filter.origin,
                    minPrice: _filter.minPrice,
                    maxPrice: _filter.maxPrice,
                    brand: _filter.brand,
                    name: "",
                    category: _filter.category,
                  );
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductListLoaded) {
            // Apply initial filter based on categoryName and brandName
            final filteredProducts = _applyFilters(state.products);

            final origins = state.products
                .map((product) => product.origin)
                .toSet()
                .toList();
            final categories = state.products
                .map((product) => product.category)
                .toSet()
                .toList();
            final brands =
                state.products.map((product) => product.brand).toSet().toList();

            return Column(
              children: [
                _buildFilterRow(origins, brands, categories),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GridTile(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(product: product),
                              ),
                            );
                          },
                          child: ContextMenuWidget(
                            menuProvider: (MenuRequest request) {
                              return Menu(
                                children: [
                                  MenuAction(
                                    title: 'Favourite ',
                                    callback: () {},
                                    image: MenuImage.icon(Icons.favorite),
                                  ),
                                ],
                              );
                            },
                            child: Card(
                              elevation: 4.0,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Hero(
                                      tag: product.name,
                                      child: CachedNetworkImage(
                                        imageUrl: product.imageUrl,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("brand"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              product.brand,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("price"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              numberFormatter.formatCurrency(
                                                  product.price, context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_isAdLoaded)
                  SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
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
  void dispose() {
    super.dispose();
    bannerAd.dispose();
  }

  @override
  void initState() {
    super.initState();

    _filter = ProductFilter(
      origin: "Bangladesh",
      minPrice: 0,
      maxPrice: double.infinity,
      brand: widget.brandName ?? "", // Use brandName if provided
      name: "",
      category: widget.categoryName ?? "",
    );

    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-4470111026859700/3188119396',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  List<CommonProduct> _applyFilters(List<CommonProduct> products) {
    return products.where((product) {
      final matchesOrigin =
          _filter.origin.isEmpty || product.origin == _filter.origin;
      final matchesPrice = product.price >= _filter.minPrice &&
          product.price <= _filter.maxPrice;
      final matchesBrand =
          _filter.brand.isEmpty || product.brand == _filter.brand;
      final matchesCategory =
          _filter.category.isEmpty || product.category == _filter.category;
      final matchesName = _filter.name.isEmpty ||
          product.name.toLowerCase().contains(_filter.name.toLowerCase());
      return matchesOrigin &&
          matchesPrice &&
          matchesBrand &&
          matchesName &&
          matchesCategory;
    }).toList();
  }

  Widget _buildDropdownChip(
    BuildContext context,
    String translation,
    String selectedValue,
    String hint,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
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
                    title: Text(
                      translation == "category"
                          ? AppLocalizations.of(context).category(item)
                          : translation == "brand"
                              ? AppLocalizations.of(context).brand(item)
                              : item,
                    ),
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

  Widget _buildFilterRow(
      List<String> origins, List<String> brands, List<String> categories) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              _buildDropdownChip(
                context,
                "country",
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
                      name: _filter.name,
                      category: _filter.category,
                    );
                  });
                },
              ),
              const SizedBox(width: 8),
              _buildDropdownChip(
                context,
                "brand",
                AppLocalizations.of(context).brand(_filter.brand),
                AppLocalizations.of(context).translate("brand"),
                brands,
                (value) {
                  setState(() {
                    _filter = ProductFilter(
                      origin: _filter.origin,
                      minPrice: _filter.minPrice,
                      maxPrice: _filter.maxPrice,
                      brand: value ?? "",
                      name: _filter.name,
                      category: _filter.category,
                    );
                  });
                },
              ),
              const SizedBox(width: 8),
              _buildDropdownChip(
                context,
                "category",
                AppLocalizations.of(context).category(_filter.category),
                AppLocalizations.of(context).translate("category"),
                categories,
                (value) {
                  setState(() {
                    _filter = ProductFilter(
                      origin: _filter.origin,
                      minPrice: _filter.minPrice,
                      maxPrice: _filter.maxPrice,
                      category: value ?? "",
                      name: _filter.name,
                      brand: _filter.brand,
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
