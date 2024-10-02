import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/welcome/presentation/blocs/welcome_cubit.dart';
import 'package:deshi_ponno/features/welcome/presentation/pages/select_language_page.dart';
import 'package:deshi_ponno/features/welcome/presentation/pages/select_permissions_page.dart';
import 'package:deshi_ponno/features/welcome/presentation/pages/select_theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with WidgetsBindingObserver {
  int selectedIndex = 0;
  final pageController = PageController();
  PermissionStatus _notificationStatus = PermissionStatus.denied;

  bool _isAdLoaded = false;
  late BannerAd bannerAd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: const [
                  SelectLanguagePage(),
                  SelectThemePage(),
                  SelectPermissionPage(),
                ],
              ),
            ),
            AnimatedContainer(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsetsDirectional.all(20),
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isAdLoaded)
                    SizedBox(
                      height: bannerAd.size.height.toDouble(),
                      width: bannerAd.size.width.toDouble(),
                      child: AdWidget(ad: bannerAd),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible: selectedIndex > 0,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: ElevatedButton(
                          onPressed: () {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          child: Text(
                            AppLocalizations.of(context).translate("previous"),
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        onDotClicked: (index) => pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        effect: WormEffect(
                          dotColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          activeDotColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      selectedIndex == 2
                          ? ElevatedButton(
                              onPressed: () async {
                                if (_notificationStatus.isGranted) {
                                  context
                                      .read<WelcomeCubit>()
                                      .finishWelcome()
                                      .then((_) {
                                    _navigateToNextScreen(context);
                                  });
                                } else {
                                  await _requestPermission();
                                  if (_notificationStatus.isPermanentlyDenied) {
                                    openAppSettings();
                                  }
                                }
                              },
                              child: Text(
                                _notificationStatus.isGranted
                                    ? AppLocalizations.of(context)
                                        .translate("done")
                                    : _notificationStatus.isPermanentlyDenied
                                        ? AppLocalizations.of(context)
                                            .translate("next")
                                        : AppLocalizations.of(context)
                                            .translate("next"),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              child: Text(
                                AppLocalizations.of(context).translate("next"),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    bannerAd.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  initState() {
    super.initState();
    _checkNotificationPermission();
    WidgetsBinding.instance.addObserver(this);
    pageController.addListener(() {
      setState(() {
        selectedIndex = pageController.page!.round();
      });
    });
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-4470111026859700/1331595322',
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

  Future<void> _checkNotificationPermission() async {
    final status = await Permission.notification.status;
    setState(() {
      _notificationStatus = status;
    });
  }

  void _navigateToNextScreen(BuildContext context) async {
    final CheckUserLoggedIn checkUserLoggedIn =
        context.read<CheckUserLoggedIn>();

    final result = await Future.delayed(const Duration(seconds: 0), () {
      return checkUserLoggedIn(NoParams());
    });

    result.fold(
      (failure) {
        Navigator.pushReplacementNamed(context, '/login');
      },
      (isLoggedIn) {
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkNotificationPermission();
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();
    setState(() {
      _notificationStatus = status;
    });
  }
}
