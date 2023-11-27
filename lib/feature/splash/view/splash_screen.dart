import 'package:demandium/data/model/notification_body.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, @required this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    Get.find<CartController>().getCartData();
    _route();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        Timer(const Duration(seconds: 1), () async {
          bool isAvailableUpdate = false;

          String minimumVersion = "1.1.0";
          double? minimumBaseVersion = 1.0;
          double? minimumLastVersion = 0;

          String appVersion = AppConstants.appVersion;
          double? baseVersion = double.tryParse(appVersion.substring(0, 3));
          double lastVersion = 0;
          if (appVersion.length > 3) {
            lastVersion = double.tryParse(appVersion.substring(4, 5))!;
          }

          if (GetPlatform.isAndroid &&
              Get.find<SplashController>()
                      .configModel
                      .content!
                      .minimumVersion !=
                  null) {
            minimumVersion = Get.find<SplashController>()
                .configModel
                .content!
                .minimumVersion!
                .minVersionForAndroid!
                .toString();
            if (minimumVersion.length == 1) {
              minimumVersion = "$minimumVersion.0";
            }
            if (minimumVersion.length == 3) {
              minimumVersion = "$minimumVersion.0";
            }
            minimumBaseVersion =
                double.tryParse(minimumVersion.substring(0, 3));
            minimumLastVersion =
                double.tryParse(minimumVersion.substring(4, 5));

            if (minimumBaseVersion! > baseVersion!) {
              isAvailableUpdate = true;
            } else if (minimumBaseVersion == baseVersion) {
              if (minimumLastVersion! > lastVersion) {
                isAvailableUpdate = true;
              } else {
                isAvailableUpdate = false;
              }
            } else {
              isAvailableUpdate = false;
            }
          } else if (GetPlatform.isIOS &&
              Get.find<SplashController>()
                      .configModel
                      .content!
                      .minimumVersion !=
                  null) {
            minimumVersion = Get.find<SplashController>()
                .configModel
                .content!
                .minimumVersion!
                .minVersionForIos!;
            if (minimumVersion.length == 1) {
              minimumVersion = "$minimumVersion.0";
            }
            if (minimumVersion.length == 3) {
              minimumVersion = "$minimumVersion.0";
            }
            minimumBaseVersion =
                double.tryParse(minimumVersion.substring(0, 3));
            if (minimumVersion.length > 3) {
              minimumLastVersion =
                  double.tryParse(minimumVersion.substring(4, 5));
            }
            if (minimumBaseVersion! > baseVersion!) {
              isAvailableUpdate = true;
            } else if (minimumBaseVersion == baseVersion) {
              if (minimumLastVersion! > lastVersion) {
                isAvailableUpdate = true;
              } else {
                isAvailableUpdate = false;
              }
            } else {
              isAvailableUpdate = false;
            }
          }
          if (isAvailableUpdate) {
            Get.offNamed(RouteHelper.getUpdateRoute(isAvailableUpdate));
          } else {
            if (widget.body != null) {
              String notificationType = widget.body?.type ?? "";

              switch (notificationType) {
                case "chatting":
                  {
                    Get.toNamed(RouteHelper.getChatScreenRoute(
                      widget.body?.channelId ?? "",
                      widget.body?.userName ?? "",
                      widget.body?.userProfileImage ?? "",
                      widget.body?.userPhone ?? "",
                      "",
                      widget.body?.userType ?? "",
                    ));
                  }
                  break;

                case "booking":
                  {
                    if (widget.body!.bookingId != null &&
                        widget.body!.bookingId != "") {
                      Get.toNamed(RouteHelper.getBookingDetailsScreen(
                          widget.body!.bookingId!, 'fromNotification'));
                    } else {
                      Get.toNamed(RouteHelper.getMainRoute(""));
                    }
                  }
                  break;

                case "privacy_policy":
                  {
                    Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
                  }
                  break;

                case "terms_and_conditions":
                  {
                    Get.toNamed(
                        RouteHelper.getHtmlRoute("terms-and-condition"));
                  }
                  break;

                default:
                  {
                    Get.toNamed(RouteHelper.getNotificationRoute());
                  }
                  break;
              }
            } else {
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                if (Get.find<LocationController>().getUserAddress() != null) {
                  Get.offNamed(RouteHelper.getInitialRoute());
                } else {
                  Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
                }
              } else {
                if (!Get.find<SplashController>().isSplashSeen()) {
                  // Get.offNamed(RouteHelper.getLanguageScreen('fromOthers'));
                  Get.offNamed(RouteHelper.onBoardScreen);
                } else {
                  Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                }
              }
            }
          }
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        body: GetBuilder<SplashController>(builder: (splashController) {
          PriceConverter.getCurrency();
          return splashController.hasConnection
              ?
              //  Column(
              //     // mainAxisSize: MainAxisSize.min,
              //     //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.33,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Center(
              //             child: Image.asset(
              //               Images.logo,
              //               width: Dimensions.logoSize,
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.23,
              //       ),
              //       Row(
              //         children: [
              //           Image.asset(
              //             Images.splashscreendown,
              //             width: MediaQuery.of(context).size.width,
              //           ),
              //         ],
              //       )
              //       //const SizedBox(height: Dimensions.paddingSizeLarge),
              //       // Expanded(
              //       //   flex: 3,
              //       //   child: Image.asset(
              //       //     Images.splashscreendown,
              //       //     width: Dimensions.logoSize,
              //       //   ),
              //       // ),
              //     ],
              //   )
              Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //For LOGO --------
                      Container(
                        height: 200,
                        width: 200,
                        // color: Colors.red,
                        child: Image.asset(
                          Images.logo,
                          fit: BoxFit.fill,
                        ),
                      ),
                      //TOP 1st
                      Positioned(
                          height: 160,
                          width: 160,
                          top: 45,
                          left: -45,
                          child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(5 / 360),
                              child: Image.asset(Images.rench))),
                      //TOP 2nd
                      Positioned(
                          height: 160,
                          width: 160,
                          top: 45,
                          right: -25,
                          child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(10 / 360),
                              child: Image.asset(Images.drillMachine))),
                      //BOTTOM 1st
                      Positioned(
                          height: 130,
                          width: 130,
                          bottom: -25,
                          left: -35,
                          child: Image.asset(Images.paintBrush)),
                      //BOTTOM 2nd
                      Positioned(
                          height: 160,
                          width: 160,
                          bottom: -10,
                          right: -40,
                          child: Image.asset(Images.vaccum)),
                    ],
                  ),
                )
              : NoInternetScreen(child: SplashScreen(body: widget.body));
        }),
      ),
    );
  }
}
