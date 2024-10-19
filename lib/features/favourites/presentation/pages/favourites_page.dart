import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("favourites"),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset("assets/lottie/construction.json"),
            const SizedBox(height: 50),
            Text("Under construction...")
          ],
        ),
      ),
    );
  }
}
