import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/home_page/presentation/widgets/product_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';

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
        // Slidable(
        //   startActionPane: ActionPane(
        //     motion: const StretchMotion(),
        //     children: [
        //       SlidableAction(
        //         onPressed: (BuildContext context) {},
        //         icon: Icons.favorite,
        //         backgroundColor: Colors.green,
        //         foregroundColor: Colors.white,
        //         label: 'Favorite',
        //       ),
        //     ],
        //   ),
        //   endActionPane: ActionPane(
        //     motion: const StretchMotion(),
        //     children: [
        //       SlidableAction(
        //         onPressed: (BuildContext context) {},
        //         icon: Icons.delete_forever_outlined,
        //         backgroundColor: Colors.red,
        //         label: 'Delete',
        //       ),
        //     ],
        //   ),
        // child: ListTile(
        ListTile(
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
