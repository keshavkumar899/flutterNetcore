import 'dart:async';
import 'dart:developer' as developer;

import 'package:app_links/app_links.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keshav_s_application2/presentation/splash_screen/splash_screen.dart';
import 'package:keshav_s_application2/screenwithoutlogin/HtmlPage.dart';
import 'package:keshav_s_application2/widgets/connection_lost.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
// import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:smartech_nudges/listener/px_listener.dart';
import 'package:smartech_nudges/netcore_px.dart';
import 'package:smartech_nudges/px_widget.dart';
import 'package:smartech_nudges/tracker/route_obersver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'core/app_export.dart';
//import 'package:location/location.dart';
import 'dart:io' show Platform;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

var response1;

/// Logger that works in both debug and release mode
/// Use this instead of debugPrint() or print() for release mode logging
void appLog(String message, {String name = 'FabFurni'}) {
  developer.log(message, name: name);
  // Also print in debug mode for convenience
  if (kDebugMode) {
    debugPrint('[$name] $message');
  }
}

/// Class to store pending deep link data for showing on HomeScreen
class PendingDeepLink {
  static String? originalUrl;
  static String? resolvedUrl;
  static bool hasPendingLink = false;
  static DateTime? _timestamp;
  
  static void setPending(String original, String resolved) {
    originalUrl = original;
    resolvedUrl = resolved;
    hasPendingLink = true;
    _timestamp = DateTime.now();
    debugPrint("PendingDeepLink: Stored pending link at $_timestamp");
  }
  
  static void clear() {
    debugPrint("PendingDeepLink: Clearing pending data");
    originalUrl = null;
    resolvedUrl = null;
    hasPendingLink = false;
    _timestamp = null;
  }
  
  /// Call this from HomeScreen1 to check and show pending dialog
  static void showPendingDialogIfExists(BuildContext context) {
    debugPrint("PendingDeepLink: Checking for pending link - hasPending: $hasPendingLink, original: $originalUrl, resolved: $resolvedUrl");
    
    // Check if we have valid pending data and it's not stale (within 30 seconds)
    if (hasPendingLink && 
        originalUrl != null && 
        resolvedUrl != null &&
        _timestamp != null &&
        DateTime.now().difference(_timestamp!).inSeconds < 30) {
      
      final original = originalUrl!;
      final resolved = resolvedUrl!;
      
      // Clear immediately to prevent duplicate dialogs
      clear();
      
      // Delay slightly to ensure screen is fully built
      Future.delayed(const Duration(milliseconds: 500), () {
        showResolvedUrlDialog(original, resolved);
      });
    } else if (hasPendingLink) {
      // Stale data, just clear it
      debugPrint("PendingDeepLink: Clearing stale pending data");
      clear();
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyAyoGDHO83zRE-iNren011TmrR3Y0Xxm50",

        authDomain: "fabfurni.firebaseapp.com",

        projectId: "fabfurni",

        storageBucket: "fabfurni.firebasestorage.app",

        messagingSenderId: "893910930509",

        appId: "1:893910930509:web:9e6d17e3d82499e6e07804",

        measurementId: "G-4YLYZ1EXJL"

    ));
  }
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  // if(Smartech().getUserIdentity().toString().isEmpty){
  // if (Platform.isAndroid) {
  //   final fcmToken = await FirebaseMessaging.instance.getToken();
  //   print(fcmToken);
  //   Smartech().login('8920616622');
  // }
  // if (Platform.isIOS) {
  //   Smartech().login('9873103345');
  // }

  // }
  // print(Platform.operatingSystem);

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
  //     "update":"sent by iOS platform",
  //     "platforms_touchpoint":"[iOS, Android, Desktop, Mobile Web, CTV, ATV, Apple TV]",
  //   };
  //   print(mapiOS);
  //   Smartech().updateUserProfile(mapiOS);
  // }

  // Smartech().login('pid1816735');
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

    //resolveLinkWithDio("https://elink.savmoney.me/vtrack?clientid=170681&ul=BgVRBlNEBR5TX15DB154R1VASw4KWVYdTx4=&ml=BA9VSFJEA1MESw==&sl=dUolSDdrSTF9Y0tUClBWXxpFBBUIWF0BSkwLU0xQ&pp=0&c=0000&fl=X0ISRBECGk1DVkFQFkkWVURGSw8MWVhLew88UHkiXFZrI1M=&ext=");
  });

  Smartech().onHandleDeeplink((String? smtDeeplinkSource,
      String? smtDeeplink,
      Map<dynamic, dynamic>? smtPayload,
      Map<dynamic, dynamic>? smtCustomPayload) async {
    // String deeplink1=smtDeeplink!;
    // print(deeplink1);
    print("smtDeeplink: "+smtDeeplink!);
    final Map<String, dynamic> payload =
    smtCustomPayload!.map((key, value) => MapEntry(key.toString(), value));

    // Print all key-value pairs
    payload.forEach((key, value) {
      print("$key : $value");
    });
    

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
  //getLocation();
}

/// Returns the resolved URL or null if failed
Future<String?> resolveLinkWithDio(String linkUrl, {bool showDialog = true}) async {
  // String? resolvedUrl;
  //
  // // Clear any existing pending data first
  // PendingDeepLink.clear();
  //
  // appLog("=== URL Resolution Started ===");
  // appLog("Original URL: $linkUrl");
  //
  // try {
  //   // DON'T decode the URL - keep original encoding as the server expects it
  //   final dioClient = dio.Dio();
  //
  //   // Configure to follow redirects and capture final URL
  //   dioClient.options.followRedirects = true;
  //   dioClient.options.maxRedirects = 15;
  //   dioClient.options.connectTimeout = const Duration(seconds: 20);
  //   dioClient.options.receiveTimeout = const Duration(seconds: 20);
  //   dioClient.options.validateStatus = (status) {
  //     // Accept all status codes to see what we get
  //     return status != null && status < 500;
  //   };
  //   dioClient.options.headers = {
  //     'User-Agent': 'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
  //     'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
  //     'Accept-Language': 'en-US,en;q=0.5',
  //   };
  //
  //   final response = await dioClient.get(linkUrl);
  //
  //
  //   appLog("Response status: ${response.statusCode}");
  //   appLog("Final URL (realUri): ${response.realUri}");
  //
  //   // First check if HTTP redirect happened
  //   resolvedUrl = response.realUri.toString();
  //
  //   // If URL didn't change or still contains app.link, try to extract from HTML
  //   // Branch/app.link URLs use JavaScript redirects which Dio can't follow
  //   if (resolvedUrl == linkUrl || resolvedUrl.contains('app.link')) {
  //     final responseBody = response.data?.toString() ?? '';
  //     appLog("Checking HTML for JavaScript redirect...");
  //
  //     // Try to extract URL from various redirect patterns in HTML
  //     String? extractedUrl = _extractRedirectUrl(responseBody);
  //     if (extractedUrl != null && extractedUrl.isNotEmpty) {
  //       resolvedUrl = extractedUrl;
  //       appLog("Extracted redirect URL from HTML: $resolvedUrl");
  //     }
  //   }
  //
  //   appLog("Final resolved URL: $resolvedUrl");
  //
  //   // Store pending link to show dialog when HomeScreen1 loads
  //   if (showDialog) {
  //     PendingDeepLink.setPending(linkUrl, resolvedUrl ?? linkUrl);
  //     appLog("Pending deep link stored - will show on HomeScreen1");
  //   }
  //
  // } catch (e) {
  //   appLog("Error resolving link with Dio: $e");
  //   PendingDeepLink.clear();
  //
  //   if (showDialog && Get.context != null) {
  //     _showUrlSnackbar('Could Not Resolve URL', linkUrl);
  //   }
  // }
  //
  // appLog("=== URL Resolution Ended ===");

  try {
    final dio = Dio();
dio.options.headers['User-Agent'] =
'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148';

final response = await dio.get(linkUrl);

  if (response.statusCode == 200) {
 final resolvedUrl = response.realUri.toString();
 print("Resolved URL with Dio: $resolvedUrl");
 } else {
print("Failed to resolve link: HTTP ${response.statusCode}");
}
  } catch (e) {
  print("Error resolving link with Dio: $e");
 }

  //return resolvedUrl;
}

/// Extract redirect URL from HTML response body
/// Handles meta refresh, JavaScript redirects, and Branch-specific patterns
String? _extractRedirectUrl(String html) {
  if (html.isEmpty) return null;
  
  try {
    // Pattern 1: Look for px.netcorecloud.com URL (known destination)
    if (html.contains('px.netcorecloud.com')) {
      final netcorePattern = RegExp(r'https://px\.netcorecloud\.com[^\s"<>]*');
      var match = netcorePattern.firstMatch(html);
      if (match != null) {
        appLog("Found netcorecloud URL");
        return match.group(0);
      }
    }
    
    // Pattern 2: Meta refresh tag
    if (html.contains('http-equiv')) {
      final metaRefreshPattern = RegExp(r'url=([^"<>\s]+)', caseSensitive: false);
      var match = metaRefreshPattern.firstMatch(html);
      if (match != null) {
        appLog("Found meta refresh redirect");
        return match.group(1);
      }
    }
    
    // Pattern 3: JavaScript window.location
    if (html.contains('window.location')) {
      final jsLocationPattern = RegExp(r'window\.location[^=]*=\s*"([^"]+)"');
      var match = jsLocationPattern.firstMatch(html);
      if (match != null) {
        appLog("Found window.location redirect");
        return match.group(1);
      }
    }
    
    // Pattern 4: JavaScript location.replace
    if (html.contains('location.replace')) {
      final jsReplacePattern = RegExp(r'location\.replace\("([^"]+)"\)');
      var match = jsReplacePattern.firstMatch(html);
      if (match != null) {
        appLog("Found location.replace redirect");
        return match.group(1);
      }
    }
    
    // Pattern 5: Branch fallback_url in JSON
    if (html.contains('fallback_url') || html.contains('desktop_url')) {
      final branchPattern = RegExp(r'"(?:fallback_url|desktop_url)"\s*:\s*"([^"]+)"');
      var match = branchPattern.firstMatch(html);
      if (match != null) {
        appLog("Found Branch fallback URL");
        var url = match.group(1);
        url = url?.replaceAll(r'\/', '/');
        return url;
      }
    }
    
    appLog("No redirect URL found in HTML");
  } catch (e) {
    appLog("Error extracting redirect URL: $e");
  }
  
  return null;
}

/// Shows a snackbar with the URL that failed to resolve
void _showUrlSnackbar(String title, String url) {
  Get.snackbar(
    title,
    url,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 8),
    isDismissible: true,
    backgroundColor: Colors.red.shade100,
    colorText: Colors.black87,
    messageText: SelectableText(
      url,
      style: const TextStyle(fontSize: 12, color: Colors.black87),
    ),
    mainButton: TextButton(
      onPressed: () {
        Get.back();
        // Copy URL to clipboard
        Clipboard.setData(ClipboardData(text: url));
        Get.snackbar('Copied', 'URL copied to clipboard', 
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      },
      child: const Text('COPY', style: TextStyle(color: Colors.blue)),
    ),
  );
}

/// Shows a dialog with the original and resolved URL
void showResolvedUrlDialog(String originalUrl, String resolvedUrl) {
  Get.dialog(
    AlertDialog(
      title: const Text('URL Resolved'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Original URL:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            SelectableText(originalUrl, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 16),
            const Text('Resolved URL:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            SelectableText(resolvedUrl, style: const TextStyle(fontSize: 12, color: Colors.blue)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            // Navigate based on resolved URL
            handleResolvedUrl(resolvedUrl);
          },
          child: const Text('Open'),
        ),
      ],
    ),
  );
}

/// Handle navigation based on resolved URL
void handleResolvedUrl(String resolvedUrl) {
  if (resolvedUrl.contains('/about_us_screen') || resolvedUrl.contains('about-us')) {
    Get.toNamed(AppRoutes.aboutUsScreen);
  } else if (resolvedUrl.contains('/terms_of_condition_screen') || resolvedUrl.contains('terms')) {
    Get.toNamed(AppRoutes.termsOfConditionScreen);
  } else if (resolvedUrl.contains('/log_in_screen') || resolvedUrl.contains('login')) {
    Get.toNamed(AppRoutes.logInScreen);
  } else if (resolvedUrl.startsWith('https://') || resolvedUrl.startsWith('http://')) {
    // Open in browser or webview
    launchUrl(Uri.parse(resolvedUrl));
  }
}

// void getLocation() async {
//   Location location = Location();
//
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   // ignore: unused_local_variable
//   LocationData _locationData;
//
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return;
//     }
//   }
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//   }
//
//   _locationData = await location.getLocation();
// }




class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = true;
  bool isOffline = false;
  StreamSubscription? subscription;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  StreamSubscription<Map>? _branchSubscription;

  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
    startChecking();

    // Initialize deep links handling for elink.savmoney.me URLs
    initDeepLinks();

    // Initialize Branch SDK (must await init before listSession)
    initBranch();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAndRemindForNotifications(context);
    });
  }
  
  /// Initialize Branch SDK - init() must complete before listSession()
  Future<void> initBranch() async {
    await FlutterBranchSdk.init();
    initBranchSession();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    _branchSubscription?.cancel();
    subscription!.cancel();

    super.dispose();
  }

  Future<bool> checkNotificationPermission() async {
    return await permission.Permission.notification.isGranted;
  }

  Future<void> requestNotificationPermission() async {
    await permission.Permission.notification.request();
  }

  Future<bool> shouldRemindUser() async {
    final prefs = await SharedPreferences.getInstance();
    int? lastReminder = prefs.getInt('lastNotificationReminder');

    if (lastReminder == null) return true; // First-time users should be reminded

    DateTime lastReminderTime = DateTime.fromMillisecondsSinceEpoch(lastReminder);
    DateTime now = DateTime.now();

    // Check if 48 hours (2 days) have passed
    return now.difference(lastReminderTime).inHours >= 48;
  }

  Future<void> saveReminderTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('lastNotificationReminder', DateTime.now().millisecondsSinceEpoch);
  }

  void promptToEnableNotifications(BuildContext context) async {
    bool granted = await checkNotificationPermission();
    if (granted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enable Notifications"),
          content: Text("You're missing important updates! Enable notifications in Settings."),
          actions: [
            TextButton(
              onPressed: () async {
                await permission.openAppSettings();
                // saveReminderTimestamp(); // Save timestamp after prompt
                Navigator.of(context).pop();
              },
              child: Text("Open Settings"),
            ),
            TextButton(
              onPressed: () {
                saveReminderTimestamp();
                Navigator.of(context).pop();
              },
              child: Text("Maybe Later"),
            ),
          ],
        );
      },
    );
  }

  void checkAndRemindForNotifications(BuildContext context) async {
    bool permissionGranted = await checkNotificationPermission();
    bool shouldRemind = await shouldRemindUser();

    if (!permissionGranted ) {
      Future.delayed(Duration(seconds: 3), () => promptToEnableNotifications(context)); // Delay for better UX
    }
  }

  Future<void> startChecking() async {
    final List<ConnectivityResult> result =
        await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  /// Initialize Branch SDK and listen for deep link data
  void initBranchSession() {
    _branchSubscription = FlutterBranchSdk.listSession().listen((data) {
      debugPrint('Branch Deep Link Data: $data');
      
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        // A Branch link was clicked - handle the deep link
        handleBranchDeepLink(data);
      }
    }, onError: (error) {
      debugPrint('Branch InitSession error: ${error.toString()}');
    });

    // Uncomment the line below to validate your Branch integration during development
    // FlutterBranchSdk.validateSDKIntegration();
  }

  /// Handle Branch deep link data and navigate to appropriate screen
  /// Includes delay for terminated state to ensure app is fully initialized
  void handleBranchDeepLink(Map<dynamic, dynamic> data) {
    debugPrint('Handling Branch Deep Link: $data');
    
    // Extract deep link parameters
    String? deepLinkPath = data['~feature']?.toString();
    String? canonicalUrl = data['\$canonical_url']?.toString();
    String? customData = data['custom_data']?.toString();
    
    // Check if app was launched from terminated state
    // The '+is_first_session' key indicates first session after install or terminated state
    bool isFromTerminatedState = data['+is_first_session'] == true || 
                                  data['+non_branch_link'] == null;
    
    // Add delay for terminated state to ensure app is fully initialized
    // This allows splash screen and navigation stack to be ready
    int delayMs = isFromTerminatedState ? 2500 : 500;
    
    Future.delayed(Duration(milliseconds: delayMs), () {
      _navigateFromBranchLink(data, canonicalUrl);
    });
    
    // Log the deep link event to Branch
    // BranchEvent(BranchStandardEvent.VIEW_ITEM)
    //   .addCustomData('deeplink_handled', 'true')
    //   .addCustomData('from_terminated', isFromTerminatedState.toString())
    //   .logEvent();
  }
  
  /// Navigate to the appropriate screen based on Branch link data
  void _navigateFromBranchLink(Map<dynamic, dynamic> data, String? canonicalUrl) {
    // Ensure GetX context is available before navigating
    if (Get.context == null) {
      debugPrint('Navigation context not ready, retrying...');
      Future.delayed(const Duration(milliseconds: 500), () {
        _navigateFromBranchLink(data, canonicalUrl);
      });
      return;
    }
    
    if (data.containsKey('screen')) {
      String screen = data['screen'].toString();
      switch (screen) {
        case 'product_detail':
          // Navigate to product detail with product ID
          String? productId = data['product_id']?.toString();
          if (productId != null) {
            Get.toNamed(AppRoutes.productDetailScreen, arguments: [productId]);
          }
          break;
        case 'about_us':
          Get.toNamed(AppRoutes.aboutUsScreen);
          break;
        case 'terms_of_condition':
          Get.toNamed(AppRoutes.termsOfConditionScreen);
          break;
        case 'login':
          Get.toNamed(AppRoutes.logInScreen);
          break;
        default:
          debugPrint('Unknown screen: $screen');
      }
    } else if (data.containsKey('\$deeplink_path')) {
      // Handle $deeplink_path parameter from Branch link
      String deepLinkPath = data['\$deeplink_path'].toString();
      debugPrint('Deep link path: $deepLinkPath');
      
      if (deepLinkPath == '/about_us_screen') {
        Get.toNamed(AppRoutes.aboutUsScreen);
      } else if (deepLinkPath == '/terms_of_condition_screen') {
        Get.toNamed(AppRoutes.termsOfConditionScreen);
      } else if (deepLinkPath == '/log_in_screen') {
        Get.toNamed(AppRoutes.logInScreen);
      } else if (deepLinkPath.contains('https')) {
        launchUrl(Uri.parse(deepLinkPath));
      }
    } else if (canonicalUrl != null && canonicalUrl.contains('https')) {
      // Open external URL in browser
      launchUrl(Uri.parse(canonicalUrl));
    }
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Check for initial link (app opened from terminated state via deep link)
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        debugPrint('Initial AppLink (cold start): $initialUri');
        // Delay to ensure app is fully initialized
        Future.delayed(const Duration(milliseconds: 2500), () {
          openAppLink(initialUri);
        });
      }
    } catch (e) {
      debugPrint('Error getting initial link: $e');
    }

    // Handle links when app is running (foreground/background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink (stream): $uri');
      openAppLink(uri);
    });
  }

  /// Handle incoming deep link URL
  void openAppLink(Uri uri) {
    appLog('Processing deep link: $uri');
    appLog('Scheme: ${uri.scheme}, Host: ${uri.host}');
    final urlString = uri.toString();
    
    // IMPORTANT: Check fabfurni:// scheme FIRST before other conditions
    
    // Option 1: fabfurni://resolve?url=<encoded_url>
    // if (uri.scheme == 'fabfurni' && uri.host == 'resolve') {
    //   final urlToResolve = uri.queryParameters['url'];
    //   if (urlToResolve != null && urlToResolve.isNotEmpty) {
    //     appLog('Resolving URL from custom scheme (query param): $urlToResolve');
    //     resolveLinkWithDio(urlToResolve, showDialog: true);
    //   }
    // }
    // Option 2: fabfurni://elink.savmoney.me/vtrack?... 
    // Reconstruct the full HTTPS URL from URI components
    // else if (uri.scheme == 'fabfurni' && uri.host == 'elink.savmoney.me') {
    //   // Rebuild the URL properly with all query parameters
    //   final httpsUrl = _reconstructHttpsUrl(uri);
    //   appLog('Reconstructed HTTPS URL: $httpsUrl');
    //   resolveLinkWithDio(httpsUrl, showDialog: true);
    // }
    // Option 3: fabfurni:// with any other host containing elink.savmoney.me in path
    // else if (uri.scheme == 'fabfurni' && urlString.contains('elink.savmoney.me')) {
    //   final httpsUrl = _reconstructHttpsUrl(uri);
    //   appLog('Reconstructed HTTPS URL (path match): $httpsUrl');
    //   resolveLinkWithDio(httpsUrl, showDialog: true);
    // }
    // Handle other fabfurni:// deep links (navigation like /about, /login)
    // else if (uri.scheme == 'fabfurni') {
    //   handleFabfurniDeepLink(uri);
    // }
    // Check if this is an https:// smartechapp.app.link URL
     if ((uri.scheme == 'https' || uri.scheme == 'http') &&
             (uri.host == 'smartechapp.app.link' || urlString.contains('smartechapp.app.link'))) {
      appLog('Detected https smartechapp.app.link URL - resolving...');
      resolveLinkWithDio(urlString, showDialog: true);
    }
    // Fallback for other URLs - only if it's http/https
    else if (uri.scheme == 'https' || uri.scheme == 'http') {
      appLog('Unknown http(s) URL, attempting to resolve: $urlString');
      resolveLinkWithDio(urlString, showDialog: true);
    }
    // Unknown scheme - log and ignore
    else {
      appLog('Unsupported URL scheme: ${uri.scheme} - ignoring');
    }
  }

  /// Reconstruct HTTPS URL from a fabfurni:// URI, preserving all query parameters
  String _reconstructHttpsUrl(Uri uri) {
    // Build the query string from all query parameters
    String queryString = '';
    if (uri.queryParameters.isNotEmpty) {
      final params = uri.queryParameters.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      queryString = '?$params';
    }
    
    final reconstructedUrl = 'https://${uri.host}${uri.path}$queryString';
    debugPrint('URI host: ${uri.host}');
    debugPrint('URI path: ${uri.path}');
    debugPrint('URI queryParameters: ${uri.queryParameters}');
    debugPrint('Reconstructed: $reconstructedUrl');
    
    return reconstructedUrl;
  }

  /// Handle fabfurni:// custom URI scheme deep links
  void handleFabfurniDeepLink(Uri uri) {
    final path = uri.path.isNotEmpty ? uri.path : '/${uri.host}';
    debugPrint('Handling fabfurni deep link path: $path');
    
    switch (path) {
      case '/about_us_screen':
      case '/about':
        Get.toNamed(AppRoutes.aboutUsScreen);
        break;
      case '/terms_of_condition_screen':
      case '/terms':
        Get.toNamed(AppRoutes.termsOfConditionScreen);
        break;
      case '/log_in_screen':
      case '/login':
        Get.toNamed(AppRoutes.logInScreen);
        break;
      default:
        debugPrint('Unknown fabfurni deep link: $path');
    }
  }

  void showConnectivitySnackBar(List<ConnectivityResult> result) {
    setState(() {
      hasInternet = result != ConnectivityResult.none;
    });

    // final message = hasInternet
    //     ? 'You have again ${result.toString()}'
    //     : 'You have no internet';
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SmartechPxWidget(
      child: Sizer(builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [PxNavigationObserver()],
          builder: (context, child) {
            return hasInternet
                ? MediaQuery(
                    child: child!,
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.linear(1.0)),
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
  void onLaunchUrl(String url) async{
    print('PXDeeplink: $url');
    if (url == '/about_us_screen') {
      Get.toNamed(AppRoutes.aboutUsScreen);
    }
    if (url == '/terms_of_condition_screen') {
      Get.toNamed(AppRoutes.termsOfConditionScreen);
    }
    if (url == '/log_in_screen') {
      Get.toNamed(AppRoutes.logInScreen);
    }
    if (url.contains("https")) {
      print("navigate to browser with url");
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url)) throw 'Could not launch $_url';
    // await
    // FlutterWebBrowser.openWebPage(url: smtDeeplink);
    }


  }
}

class _PxInternalEventsListener extends PxInternalEventsListener {
  @override
  void onEvent(String eventName, Map dataFromHansel) {
    Map<String, dynamic> newMap =
    Map<String, dynamic>.from(dataFromHansel.map((key, value) {
      return MapEntry(key.toString(), value);
    }));
    Smartech().trackEvent(eventName, newMap);
    debugPrint('PXEvent: $eventName eventData : $dataFromHansel');
  }
}
