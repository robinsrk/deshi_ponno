import 'dart:developer' as dev;

import 'package:deshi_ponno/features/all_products/presentation/bloc/product_list_cubit.dart';
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
      appBar: AppBar(title: const Text('All Products')),
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
                  title: Text(product.name),
                  subtitle: Text('Brand: ${product.brand}'),
                  onTap: () {
                    // Navigate to product details page
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
