import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keshav_s_application2/presentation/home_screen/home_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/profile_one_screen/profile_one_screen.dart';
import 'package:keshav_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:keshav_s_application2/presentation/store_screen/store_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:keshav_s_application2/presentation/cart_screen/models/cart_model.dart' as carts;
import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import 'core/utils/color_constant.dart';

class landingPage extends StatefulWidget {
  // String name;
  // String user_id;
  // String chapter_id;
  // String city_id;
  // ChapterDetails chapterDetails;
  Data data;
  // List<ChapterUserDetails> chapterUserDetails;
  // Data logindata;
  //
  landingPage(this.data,);
  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {

  // String message;
  // int count;
  // Future<carts.CartModel> mycart;
  // List<carts.CartData> cartlist = [];

  // Future<carts.CartModel> getCartList() async {
  //   Map data = {
  //     'user_id': widget.data.id,
  //   };
  //   //encode Map to JSON
  //   var body = json.encode(data);
  //   var response =
  //   await dio.Dio().post("https://fabfurni.com/api/Webservice/listCart",
  //       options: dio.Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "*/*",
  //         },
  //       ),
  //       data: body);
  //   var jsonObject = jsonDecode(response.toString());
  //   if (response.statusCode == 200) {
  //     print(jsonObject);
  //
  //     if (carts.CartModel.fromJson(jsonObject).status == "true") {
  //       // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
  //
  //       return carts.CartModel.fromJson(jsonObject);
  //
  //       // inviteList.sort((a, b) => a.id.compareTo(b.id));
  //     }else if (carts.CartModel.fromJson(jsonObject).status == "false") {
  //       // message=carts.CartModel.fromJson(jsonObject).message;
  //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //     duration: Duration(seconds: 1),
  //       //     behavior: SnackBarBehavior.floating,
  //       //     margin: EdgeInsets.only(bottom: 25.0),
  //       //     content: Text(carts.CartModel.fromJson(jsonObject).message),
  //       //     backgroundColor: Colors.redAccent));
  //
  //     }
  //     else if(carts.CartModel.fromJson(jsonObject).data == null){
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         duration: Duration(seconds: 2),
  //         behavior: SnackBarBehavior.floating,
  //         margin: EdgeInsets.only(bottom: 25.0),
  //         content: Text(
  //           jsonObject['message'] + ' Please check after sometime.',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         backgroundColor: Colors.redAccent,
  //       ));
  //     }
  //     else {
  //       throw Exception('Failed to load');
  //     }
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  //   return jsonObject;
  // }

  // @override
  // void initState() {
  //   mycart = getCartList();
  //   mycart.then((value) {
  //     setState(() {
  //       cartlist = value.data;
  //       count=value.count;
  //
  //       // products=value.data;
  //       // recentuserslist = value.recentusers;
  //       // onetoonelist = value.onetoonemeeting;
  //       // interchapterlist = value.interchepter;
  //       // topuserslist=value.topUsers; //to be omitted
  //     });
  //   });
  //
  //   super.initState();
  // }
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomeScreen(widget.data,),
      StoreScreen(widget.data),
      ProfileOneScreen(widget.data),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home,
        ),
        title: ("Home".toUpperCase()),
        activeColorPrimary: Color(0xff65236A),
        inactiveColorPrimary: Color(0xff949494),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.storefront,color: Colors.grey,
        ),
        title: ("Store"),
        activeColorPrimary: Color(0xff65236A),
        inactiveColorPrimary: Color(0xff949494),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person,
        ),
        title: ("Profile".toUpperCase()),
        activeColorPrimary: Color(0xff65236A),
        inactiveColorPrimary: Color(0xff949494),
      ),
    ];
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        elevation: 24,
        backgroundColor: Colors.white,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: new Text(
          'Are you sure?',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        content: new Text('Do you want to exit the App',
            style: TextStyle(fontWeight: FontWeight.w400)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',
                style: TextStyle(fontWeight: FontWeight.w400)),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Yes',
                style: TextStyle(fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return
      // Scaffold(
      // backgroundColor:ColorConstant.purple50,
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(bottom: 0),
      //   child:
      PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Color(0xffFFFFFF), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
        true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
        true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white70,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
        NavBarStyle.style15, // Choose the nav bar style with this property.
      );
    //   ),
    // );
  }
}
