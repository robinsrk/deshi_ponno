import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

class AboutAppWidget extends StatefulWidget {
  const AboutAppWidget({
    super.key,
  });

  @override
  State<AboutAppWidget> createState() => _AboutAppWidgetState();
}

class _AboutAppWidgetState extends State<AboutAppWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              _showMyDialog();
            },
            child: Text(AppLocalizations.of(context).translate("about")),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Text(
            AppLocalizations.of(context).translate("app_title"),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate("about"),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(AppLocalizations.of(context).translate("app_description")),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
