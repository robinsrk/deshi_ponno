import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/all_products/presentation/pages/all_products_page.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final products = [
    {
      "name": "soft_drink",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Fsoft-drink.png?alt=media&token=89c40340-f799-4ebd-bb87-a8715a5468a9",
    },
    {
      "name": "juice",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Ffruit-juice.png?alt=media&token=e552df28-d70e-4d87-9d2f-ba18ad826418",
    },
    {
      "name": "coffee",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Fcoffee.png?alt=media&token=ad5d5ba6-9abd-4d91-a6bb-d6130bafa2cb",
    },
    {
      "name": "biscuit",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Fcookies.png?alt=media&token=18b0b3a8-c641-4e31-9cb5-682b7c004df9",
    },
    {
      "name": "chips",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Fchips.png?alt=media&token=e0b02d57-1e5c-4fde-861c-ca82be9ea5bb",
    },
    {
      "name": "hair_oil",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Fhair%20oil.png?alt=media&token=f7c28017-e0ac-410f-9d1d-55538449acf2",
    },
    {
      "name": "face_wash",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Fface%20wash.png?alt=media&token=53c191ef-d5a7-4a35-9fe3-9e1110e50e4e",
    },
    {
      "name": "tissue_paper",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Ftissue-paper.png?alt=media&token=84d6e234-a025-4754-a287-5ccf0b995be2",
    },
    {
      "name": "soap",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/categories%2Fsoap.png?alt=media&token=ae6a35af-962e-4726-9b2c-3667a9d4b60a",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate("category"),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(
                        brandName: '',
                        categoryName: products[index]['name'].toString(),
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: products[index]['image']!,
                      height: 50,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .category(products[index]['name'].toString()),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
