import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keshav_s_application2/widgets/connection_lost.dart';
import 'package:sizer/sizer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:smartech_nudges/listener/px_listener.dart';
import 'package:smartech_nudges/netcore_px.dart';
import 'package:smartech_nudges/px_widget.dart';
import 'package:smartech_nudges/tracker/route_obersver.dart';
import 'core/app_export.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
 // NetcorePX.instance.registerPxActionListener(action,_PxActionListenerImpl());
  NetcorePX.instance.registerPxDeeplinkListener(_PxDeeplinkListenerImpl());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
  Smartech().onHandleDeeplink((String? smtDeeplinkSource, String? smtDeeplink, Map<dynamic, dynamic>? smtPayload, Map<dynamic, dynamic>? smtCustomPayload) async {
    String deeplink=smtDeeplink!.substring(0,smtDeeplink.indexOf('?'));
    print(deeplink);
    if(deeplink=='/about_us_screen'){
      Get.toNamed(AppRoutes.aboutUsScreen);
    }
  });
  Smartech().onHandleDeeplinkActionBackground();
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
    final result = await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
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
      child: Sizer(builder:(context, orientation, deviceType){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [PxNavigationObserver.instance],
          builder: (context, child) {
            return hasInternet
                ? MediaQuery(
              child: child!,
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: 1.0),
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
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.pages,
        );}
      ),
    );
  }
}

class _PxActionListenerImpl extends PxActionListener {
  @override
  void onActionPerformed(String action) {
    debugPrint('PXAction: $action');
  }
}

class _PxDeeplinkListenerImpl extends PxDeeplinkListener {
  @override
  void onLaunchUrl(String url) {
    debugPrint('PXDeeplink: $url');
  }
}

// <key>HanselKeys</key>
// <dict>
// <key>HanselAppId</key>
// <string>BWUDOM1C5ENWY8MZ24MQN0CKA</string>
// <key>HanselAppKey</key>
// <string>HZXXUAMMHYCPBHVVPZL2F5VBJMFRTA4QAKS0RVPTZRKF8TM48Z</string>
// </dict>
