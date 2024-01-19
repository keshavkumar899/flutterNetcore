import 'dart:convert';

import 'package:keshav_s_application2/landingpage.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/log_in_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screenwithoutlogin/landingpage1.dart';
import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    fetchUser();
    super.initState();

  }

  fetchUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn")!;
    var data=prefs.getString('userData');
    if(data!=null && isLoggedIn != null && isLoggedIn){
      Map <String,dynamic>json1 = jsonDecode(prefs.getString('userData')!);
      var user1 = OtpModel.fromJson(json1);
      print(user1.data);
      Future.delayed(const Duration(milliseconds: 3000), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => landingPage(user1.data!),
        ));
        // Get.offNamed(AppRoutes.logInScreen);
      });
    }else{
      Future.delayed(const Duration(milliseconds: 3000), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => landingPage1(),
        ));
        // Get.offNamed(AppRoutes.logInScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          // padding: getPadding(
          //   top: 26,
          //   bottom: 26,
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgAppicon0202,
                height: getSize(
                  222,
                ),
                width: getSize(
                  222,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgFinallogo03,
                height: getVerticalSize(
                  44,
                ),
                width: getHorizontalSize(
                  148,
                ),
                margin: getMargin(
                  top: 350,
                  bottom: 30
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
