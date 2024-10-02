import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectPermissionPage extends StatefulWidget {
  const SelectPermissionPage({super.key});

  @override
  State<SelectPermissionPage> createState() => _SelectPermissionPageState();
}

class _SelectPermissionPageState extends State<SelectPermissionPage>
    with WidgetsBindingObserver {
  PermissionStatus _notificationStatus = PermissionStatus.denied;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 20),
          Column(
            children: [
              Text(
                AppLocalizations.of(context)
                    .translate("notification_permission"),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                "assets/images/notification.svg",
                height: 300,
                width: 200,
              ),
            ],
          ),
          _notificationStatus.isPermanentlyDenied
              ? OutlinedButton(
                  onPressed: _openAppSettings,
                  child: Text(
                    AppLocalizations.of(context)
                        .translate("allow_from_settings"),
                  ),
                )
              : OutlinedButton(
                  onPressed:
                      _notificationStatus.isGranted ? null : _requestPermission,
                  child: Text(
                    AppLocalizations.of(context).translate("allow_permission"),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    _requestPermission();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final status = await Permission.notification.status;
    setState(() {
      _notificationStatus = status;
    });
  }

  void _openAppSettings() {
    openAppSettings();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();
    setState(() {
      _notificationStatus = status;
    });
  }
}
