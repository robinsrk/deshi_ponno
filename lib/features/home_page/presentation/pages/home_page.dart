import 'package:cached_network_image/cached_network_image.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/common/presentation/bloc/product_history_bloc.dart';
import 'package:deshi_ponno/features/home_page/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/home_page/presentation/bloc/product_states.dart';
import 'package:deshi_ponno/features/home_page/presentation/pages/barcode_scanner.dart';
import 'package:deshi_ponno/features/home_page/presentation/widgets/product_details_bottom_sheet.dart';
import 'package:deshi_ponno/features/home_page/presentation/widgets/product_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAdLoaded = false;
  late BannerAd bannerAd;
  @override
  Widget build(BuildContext context) {
    final double svgWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("app_title")),
        actions: [
          IconButton(
            icon: Hero(
              tag: "profile_image",
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      FirebaseAuth.instance.currentUser!.photoURL.toString(),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/welcome.svg",
                width: svgWidth,
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      BlocConsumer<ProductCubit, ProductState>(
                        listener: (context, state) {
                          if (state is ProductLoaded) {
                            _showProductDetailsBottomSheet(
                                context, state.product);
                          } else if (state is ProductError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        // TODO: add user history
                        builder: (context, state) {
                          // if (state is ProductInitial) {
                          //   return ListTile(
                          //     title: Text(
                          //       "${AppLocalizations.of(context).translate("no_recents")}, ${AppLocalizations.of(context).translate("scan_product")}",
                          //       style: Theme.of(context).textTheme.headlineSmall,
                          //     ),
                          //   );
                          // } else if (state is ProductLoading) {
                          //   return const CircularProgressIndicator();
                          // } else if (state is ProductLoaded) {
                          //   return ProductHistory(
                          //     product: state.product,
                          //   );
                          // } else if (state is ProductError) {
                          //   return Text(state.message);
                          // }
                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<ProductHistoryBloc, ProductHistoryState>(
                        builder: (context, state) {
                          if (state is ProductHistoryLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ProductHistoryLoaded) {
                            return Flexible(
                              child: Column(
                                children: [
                                  ListTile(
                                      title: Text(
                                          AppLocalizations.of(context)
                                              .translate("recents"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall)),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.products.length,
                                      itemBuilder: (context, index) {
                                        final product = state.products[index];
                                        return ProductHistory(product: product);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is ProductHistoryError) {
                            return Center(child: Text(state.message));
                          } else if (state is ProductHistoryEmpty) {
                            return ListTile(
                              title: Text(
                                "${AppLocalizations.of(context).translate("no_recents")}, ${AppLocalizations.of(context).translate("scan_product")}",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            );
                          } else {
                            return const Center(child: Text("Error"));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                if (_isAdLoaded)
                  SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
          );
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // bannerAd.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductHistoryBloc>().add(LoadProductHistoryEvent());
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-4470111026859700/9940743932',
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
    context.read<ProductHistoryBloc>().storeScannedProduct(product);
    context.read<ProductHistoryBloc>().add(LoadProductHistoryEvent());
  }
}
