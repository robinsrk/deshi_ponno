import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class AboutAppWidget extends StatefulWidget {
  const AboutAppWidget({
    super.key,
  });

  @override
  State<AboutAppWidget> createState() => _AboutAppWidgetState();
}

class _AboutAppWidgetState extends State<AboutAppWidget> {
  final InAppReview _inAppReview = InAppReview.instance;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () {
              _showMyDialog();
            },
            child: Text(AppLocalizations.of(context).translate("about")),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {
              _inAppReview.openStoreListing();
            },
            child: Text(AppLocalizations.of(context).translate("give_review")),
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
