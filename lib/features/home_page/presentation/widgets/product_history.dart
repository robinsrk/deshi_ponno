import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/common/presentation/bloc/product_history_bloc.dart';
import 'package:deshi_ponno/features/home_page/presentation/widgets/product_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:super_context_menu/super_context_menu.dart';

class ProductHistory extends StatelessWidget {
  final CommonProduct product;
  const ProductHistory({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final NumberFormatterService numberFormatter =
        GetIt.instance<NumberFormatterService>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ContextMenuWidget(
          menuProvider: (_) {
            return Menu(
              children: [
                MenuAction(
                    title: 'Delete',
                    image: MenuImage.icon(Icons.delete),
                    attributes: MenuActionAttributes(destructive: true),
                    callback: () {
                      context
                          .read<ProductHistoryBloc>()
                          .deleteProduct(product.id);
                    }),
              ],
            );
          },
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: ListTile(
              // ListTile(
              title: Text(
                product.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              isThreeLine: true,
              subtitle: Text(
                  '${AppLocalizations.of(context).translate("brand")}: ${product.brand}\n${AppLocalizations.of(context).translate("price")}: ${numberFormatter.formatCurrency(product.price, context)}'),
              trailing: CachedNetworkImage(
                imageUrl: product.imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              onTap: () {
                _showProductDetailsBottomSheet(context, product);
              },
            ),
          ),
        )
      ],
    );
  }

  void _showProductDetailsBottomSheet(
      BuildContext context, CommonProduct product) {
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
