import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keshav_s_application2/presentation/splash_screen/splash_screen.dart';
import 'package:keshav_s_application2/widgets/connection_lost.dart';
import 'package:sizer/sizer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:smartech_nudges/listener/px_listener.dart';
import 'package:smartech_nudges/netcore_px.dart';
import 'package:smartech_nudges/px_widget.dart';
import 'package:smartech_nudges/tracker/route_obersver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'core/app_export.dart';
import 'package:location/location.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  // if(Smartech().getUserIdentity().toString().isEmpty){
    Smartech().login('8920616622');
  // }

 //  if(Platform.isAndroid){
 //    var mapandroid={
 //      "name":"keshav",
 //      "update":"sent by android platform"
 //    };
 //    print(mapandroid);
 //    Smartech().updateUserProfile(mapandroid);
 //  }
 // if(Platform.isIOS){
 //   var mapiOS={
 //     "name":"keshav",
 //     "update":"sent by iOS platform"
 //   };
 //   print(mapiOS);
 //   Smartech().updateUserProfile(mapiOS);
 // }

  //Smartech().setUserIdentity('9873103345');
  NetcorePX.instance
      .registerPxActionListener('action', _PxActionListenerImpl());
  NetcorePX.instance.registerPxDeeplinkListener(_PxDeeplinkListenerImpl());
  NetcorePX.instance
      .registerPxInternalEventsListener(_PxInternalEventsListener());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
  // Smartech().onHandleDeeplink((String? smtDeeplinkSource, String? smtDeeplink, Map<dynamic, dynamic>? smtPayload, Map<dynamic, dynamic>? smtCustomPayload) async {
  //   String deeplink=smtDeeplink!.substring(0,smtDeeplink.indexOf('?'));
  //   print(deeplink);
  //   if(deeplink=='/about_us_screen'){
  //     Get.toNamed(AppRoutes.aboutUsScreen);
  //   }
  // });
    Smartech().onHandleDeeplink((String? smtDeeplinkSource,
        String? smtDeeplink,
        Map<dynamic, dynamic>? smtPayload,
        Map<dynamic, dynamic>? smtCustomPayload) async {
      // String deeplink1=smtDeeplink!;
      // print(deeplink1);
      print('$smtDeeplink');
      print('$smtDeeplink');

      Future.delayed(const Duration(milliseconds: 2500), () async {
        if (smtDeeplinkSource == 'PushNotification') {
          print(smtDeeplink);
          String deeplink = smtDeeplink!.substring(0, smtDeeplink.indexOf('?'));
          if (deeplink == '/about_us_screen') {
            Get.toNamed(AppRoutes.aboutUsScreen);
          }
          if (deeplink == '/terms_of_condition_screen') {
            Get.toNamed(AppRoutes.termsOfConditionScreen);
          }
          if (deeplink == '/log_in_screen') {
            Get.toNamed(AppRoutes.logInScreen);
          }
          if (smtDeeplink.contains("https")) {
            print("navigate to browser with url");
            final Uri _url = Uri.parse(smtDeeplink);
            if (!await launchUrl(_url)) throw 'Could not launch $_url';
            // await
            // FlutterWebBrowser.openWebPage(url: smtDeeplink);
          }
        }
        if (smtDeeplinkSource == 'InAppMessage') {
          // print(smtDeeplink);
          if (smtDeeplink == '/about_us_screen') {
            Get.toNamed(AppRoutes.aboutUsScreen);
          }
          if (smtDeeplink == '/terms_of_condition_screen') {
            Get.toNamed(AppRoutes.termsOfConditionScreen);
          }
          if (smtDeeplink == '/log_in_screen') {
            Get.toNamed(AppRoutes.logInScreen);
          }
          if (smtDeeplink!.contains("https")) {
            print("navigate to browser with url");
            final Uri _url = Uri.parse(smtDeeplink);
            if (!await launchUrl(_url)) throw 'Could not launch $_url';
            // await
            // FlutterWebBrowser.openWebPage(url: smtDeeplink);
          }
        }
      });

    });

  // Smartech().onHandleDeeplinkAction();
  getLocation();
}

void getLocation() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  // ignore: unused_local_variable
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = true;
  bool isOffline = false;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
    startChecking();
  }

  Future<void> startChecking() async {
    final List<ConnectivityResult> result =
        await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  void showConnectivitySnackBar(List<ConnectivityResult> result) {
    setState(() {
      hasInternet = result != ConnectivityResult.none;
    });

    // final message = hasInternet
    //     ? 'You have again ${result.toString()}'
    //     : 'You have no internet';
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SmartechPxWidget(
      child: ResponsiveSizer
        (builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [PxNavigationObserver()],
          builder: (context, child) {
            return hasInternet
                ? MediaQuery(
                    child: child!,
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  )
                : ConnectionLostScreen();
          },
          theme: ThemeData(
            visualDensity: VisualDensity.standard,
          ),
          translations: AppLocalization(),
          locale: Get.deviceLocale, //for setting localization strings
          fallbackLocale: Locale('en', 'US'),
          title: 'FabFurni',
          initialBinding: InitialBindings(),
          home: SplashScreen(),
          // initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.pages,
        );
      }),
    );
  }
}

class _PxActionListenerImpl extends PxActionListener {
  @override
  void onActionPerformed(String action) {
    print('PXAction: $action');
  }
}

class _PxDeeplinkListenerImpl extends PxDeeplinkListener {
  @override
  void onLaunchUrl(String url) {
    if (url == '/about_us_screen') {
      Get.toNamed(AppRoutes.aboutUsScreen);
    }
    print('PXDeeplink: $url');
  }
}

class _PxInternalEventsListener extends PxInternalEventsListener {
  @override
  void onEvent(String eventName, Map dataFromHansel) {

    Map<String, dynamic> newMap =
    Map<String, dynamic>.from(dataFromHansel.map((key, value) {
      return MapEntry(key.toString(), value);
    }));
    Smartech().trackEvent(eventName, newMap );
    debugPrint('PXEvent: $eventName eventData : $dataFromHansel');
  }
}
