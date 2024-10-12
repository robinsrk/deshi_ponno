import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/all_products/presentation/pages/all_products_page.dart';
import 'package:flutter/material.dart';

class BrandsWidget extends StatefulWidget {
  const BrandsWidget({super.key});

  @override
  State<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context).translate("brands"),
              style: Theme.of(context).textTheme.headlineSmall),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductListPage(
                            brandName: 'Pran',
                            categoryName: '',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "https://seeklogo.com/images/P/pran-logo-61EDC725ED-seeklogo.com.png",
                          height: 50,
                        ),
                        Text(AppLocalizations.of(context).brand("pran"))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/brands%2Ffreash_brand-removebg-preview.png?alt=media&token=086e4b0a-72d4-4045-842d-a4ee7082122c",
                        height: 50,
                      ),
                      Text(AppLocalizations.of(context).brand("fresh"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/brands%2Fdekko-removebg-preview.png?alt=media&token=107a082d-32da-45a7-a0fa-6b3b7ae38ae2",
                        height: 50,
                      ),
                      Text(AppLocalizations.of(context).brand("dekko"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/brands%2Fharpic-logo.png?alt=media&token=c336240f-55ba-40df-8bc8-f6b5967f0c5b",
                        height: 50,
                      ),
                      Text(AppLocalizations.of(context).brand("harpic"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/deshi-ponno.appspot.com/o/brands%2Fbashundhara-group-2-removebg-preview.png?alt=media&token=e510cd74-a5f6-4180-98fa-85cabf1e2af5",
                        height: 50,
                      ),
                      Text(AppLocalizations.of(context).brand("bashundhara"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://seeklogo.com/images/P/pran-logo-61EDC725ED-seeklogo.com.png",
                        height: 50,
                      ),
                      Text(AppLocalizations.of(context).brand("pran"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://seeklogo.com/images/P/pran-logo-61EDC725ED-seeklogo.com.png",
                        height: 50,
                      ),
                      Text(AppLocalizations.of(context).brand("pran"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://seeklogo.com/images/P/pran-logo-61EDC725ED-seeklogo.com.png",
                        height: 50,
                      ),
                      Text(AppLocalizations.of(context).brand("pran"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
