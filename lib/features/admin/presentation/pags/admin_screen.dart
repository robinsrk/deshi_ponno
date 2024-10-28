import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context).translate("admin"))),
      body: const Column(
        children: [
          Text("Under construction"),
        ],
      ),
    );
  }
}
