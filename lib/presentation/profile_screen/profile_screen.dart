import 'package:keshav_s_application2/landingpage.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/core/utils/validation_functions.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ProfileScreen extends StatefulWidget {

  Data data;
  ProfileScreen(this.data);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fullnameoneController = TextEditingController();

  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(90),
                leadingWidth: 34,
                leading: AppbarImage(
                    height: getVerticalSize(0),
                    width: getHorizontalSize(0),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 25, top: 34, bottom: 42),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                title: AppbarImage(
                    height: getVerticalSize(32),
                    width: getHorizontalSize(106),
                    imagePath: ImageConstant.imgFinallogo03,
                    margin: getMargin(left: 13, top: 0, bottom: 15)),
                actions: [
                  AppbarImage(
                      height: getSize(21),
                      width: getSize(21),
                      svgPath: ImageConstant.imgSearch,
                      margin:
                      getMargin(left: 12, top: 0, right: 10, bottom: 10),
                      onTap: onTapSearch),
                  Container(
                      height: getVerticalSize(23),
                      width: getHorizontalSize(27),
                      margin:
                      getMargin(left: 20, top: 25, right: 10, bottom: 0),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            height: getVerticalSize(21),
                            width: getHorizontalSize(21),
                            svgPath: ImageConstant.imgLocation,
                            margin: getMargin(top: 5, right: 6),
                            onTap: (){
                              pushNewScreen(
                                context,
                                screen: WhislistScreen(widget.data),
                                withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                              );
                            }),
                        // AppbarSubtitle6(
                        //     text: "lbl_2".tr,
                        //     margin: getMargin(left: 17, bottom: 13))
                      ])),
                  Container(
                      height: getVerticalSize(24),
                      width: getHorizontalSize(29),
                      margin: getMargin(left: 14, top: 27, right: 31),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: CartScreen(widget.data),
                                withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                              );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => CartScreen(widget.data),
                              // ));
                            },
                            height: getVerticalSize(20),
                            width: getHorizontalSize(23),
                            svgPath: ImageConstant.imgCart,
                            margin: getMargin(top: 4, right: 6)),
                        AppbarSubtitle6(
                            text: CartScreen.count.toString(),
                            margin: getMargin(left: 17, bottom: 13))
                      ]))
                ],
                styleType: Style.bgShadowBlack90033),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 27, top: 16),
                                  child: Text("lbl_full_name".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtRobotoRegular12Purple300))),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: fullnameoneController,
                              hintText: widget.data.firstName.capitalizeFirst,
                              margin: getMargin(left: 27, top: 5, right: 26)),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 27, top: 13),
                                  child: Text("lbl_mobile_number".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtRobotoRegular12Purple300))),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: mobilenumberController,
                              hintText: widget.data.mobile,
                              margin: getMargin(left: 27, top: 5, right: 26)),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 27, top: 13),
                                  child: Text("lbl_email_id".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtRobotoRegular12Purple300))),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: emailController,
                              hintText: widget.data.email,
                              margin: getMargin(left: 27, top: 6, right: 26),
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    (!isValidEmail(value, isRequired: true))) {
                                  return "Please enter valid email";
                                }
                                return null;
                              }),
                          CustomButton(
                              height: getVerticalSize(39),
                              text: "lbl_save".tr,
                              margin: getMargin(left: 27, top: 43, right: 26),
                              variant: ButtonVariant.FillPurple900,
                              padding: ButtonPadding.PaddingAll11,
                              fontStyle: ButtonFontStyle.RobotoMedium14),
                          Spacer(),
                          // Padding(
                          //     padding: getPadding(left: 28, right: 17),
                          //     child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text("lbl_new".tr,
                          //               overflow: TextOverflow.ellipsis,
                          //               textAlign: TextAlign.left,
                          //               style: AppStyle.txtRobotoMedium9),
                          //           Text("lbl_30_off2".tr,
                          //               overflow: TextOverflow.ellipsis,
                          //               textAlign: TextAlign.left,
                          //               style: AppStyle.txtRobotoMedium9)
                          //         ])),
                          // Container(
                          //     height: getVerticalSize(86),
                          //     width: getHorizontalSize(400),
                          //     margin: getMargin(top: 31),
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //             image: fs.Svg(ImageConstant.imgGroup203),
                          //             fit: BoxFit.cover)),
                          //     child:
                          //         Stack(alignment: Alignment.center, children: [
                          //       Align(
                          //           alignment: Alignment.bottomCenter,
                          //           child: Padding(
                          //               padding: getPadding(
                          //                   left: 41, right: 44, bottom: 6),
                          //               child: Column(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   children: [
                          //                     CustomImageView(
                          //                         svgPath:
                          //                             ImageConstant.imgGroup2,
                          //                         height: getVerticalSize(47),
                          //                         width:
                          //                             getHorizontalSize(315)),
                          //                     Padding(
                          //                         padding: getPadding(
                          //                             left: 7,
                          //                             top: 4,
                          //                             right: 1),
                          //                         child: Row(
                          //                             mainAxisAlignment:
                          //                                 MainAxisAlignment
                          //                                     .spaceBetween,
                          //                             children: [
                          //                               Text("lbl_home".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8Purple900),
                          //                               Text("lbl_store".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8),
                          //                               Text("lbl_profile".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8)
                          //                             ]))
                          //                   ]))),
                          //       Align(
                          //           alignment: Alignment.center,
                          //           child: Container(
                          //               padding: getPadding(
                          //                   left: 41,
                          //                   top: 6,
                          //                   right: 41,
                          //                   bottom: 6),
                          //               decoration: BoxDecoration(
                          //                   image: DecorationImage(
                          //                       image: fs.Svg(
                          //                           ImageConstant.imgGroup203),
                          //                       fit: BoxFit.cover)),
                          //               child: Column(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.end,
                          //                   children: [
                          //                     CustomImageView(
                          //                         svgPath: ImageConstant
                          //                             .imgGroup2Gray500,
                          //                         height: getVerticalSize(47),
                          //                         width: getHorizontalSize(315),
                          //                         margin: getMargin(top: 11)),
                          //                     Padding(
                          //                         padding: getPadding(
                          //                             left: 7,
                          //                             top: 4,
                          //                             right: 3),
                          //                         child: Row(
                          //                             mainAxisAlignment:
                          //                                 MainAxisAlignment
                          //                                     .spaceBetween,
                          //                             children: [
                          //                               Text("lbl_home".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8),
                          //                               Text("lbl_store".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8),
                          //                               Text("lbl_profile".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8Purple900)
                          //                             ]))
                          //                   ])))
                          //     ])),
                          // Padding(
                          //     padding: getPadding(left: 8, top: 83, right: 8),
                          //     child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.end,
                          //         children: [
                          //           Padding(
                          //               padding: getPadding(bottom: 4),
                          //               child: Text("msg_fabiola_2_seater2".tr,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   textAlign: TextAlign.left,
                          //                   style: AppStyle
                          //                       .txtRobotoRegular12Black9001)),
                          //           Spacer(),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgCut,
                          //               height: getVerticalSize(11),
                          //               width: getHorizontalSize(7),
                          //               margin: getMargin(top: 4, bottom: 3)),
                          //           Padding(
                          //               padding: getPadding(left: 4, top: 4),
                          //               child: Text("lbl_49_999".tr,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   textAlign: TextAlign.left,
                          //                   style: AppStyle
                          //                       .txtRobotoMedium12Purple9001))
                          //         ])),
                          // Padding(
                          //     padding: getPadding(left: 8, top: 3, right: 8),
                          //     child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Padding(
                          //               padding: getPadding(bottom: 1),
                          //               child: Text(
                          //                   "msg_casacraft_by_fabfurni".tr,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   textAlign: TextAlign.left,
                          //                   style: AppStyle
                          //                       .txtRobotoRegular10Purple900)),
                          //           Spacer(),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgVectorGray500,
                          //               height: getVerticalSize(8),
                          //               width: getHorizontalSize(5),
                          //               margin: getMargin(top: 2, bottom: 3)),
                          //           Container(
                          //               height: getVerticalSize(12),
                          //               width: getHorizontalSize(32),
                          //               margin: getMargin(left: 3, top: 1),
                          //               child: Stack(
                          //                   alignment: Alignment.bottomCenter,
                          //                   children: [
                          //                     Align(
                          //                         alignment: Alignment.center,
                          //                         child: Text("lbl_99_999".tr,
                          //                             overflow:
                          //                                 TextOverflow.ellipsis,
                          //                             textAlign: TextAlign.left,
                          //                             style: AppStyle
                          //                                 .txtRobotoMedium10Gray5001)),
                          //                     Align(
                          //                         alignment:
                          //                             Alignment.bottomCenter,
                          //                         child: Padding(
                          //                             padding:
                          //                                 getPadding(bottom: 5),
                          //                             child: SizedBox(
                          //                                 width:
                          //                                     getHorizontalSize(
                          //                                         32),
                          //                                 child: Divider(
                          //                                     height:
                          //                                         getVerticalSize(
                          //                                             1),
                          //                                     thickness:
                          //                                         getVerticalSize(
                          //                                             1),
                          //                                     color: ColorConstant
                          //                                         .gray500))))
                          //                   ]))
                          //         ])),
                          // Padding(
                          //     padding: getPadding(left: 8, top: 12, right: 12),
                          //     child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.end,
                          //         children: [
                          //           Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               children: [
                          //                 Text("msg_limited_time_offer".tr,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     textAlign: TextAlign.left,
                          //                     style: AppStyle
                          //                         .txtRobotoRegular10Black9001),
                          //                 Padding(
                          //                     padding: getPadding(top: 7),
                          //                     child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         children: [
                          //                           Text(
                          //                               "lbl_ships_in_1_day".tr,
                          //                               overflow: TextOverflow
                          //                                   .ellipsis,
                          //                               textAlign:
                          //                                   TextAlign.left,
                          //                               style: AppStyle
                          //                                   .txtRobotoMedium10Black9001),
                          //                           CustomImageView(
                          //                               svgPath: ImageConstant
                          //                                   .imgCar,
                          //                               height:
                          //                                   getVerticalSize(10),
                          //                               width:
                          //                                   getHorizontalSize(
                          //                                       13),
                          //                               margin: getMargin(
                          //                                   left: 9,
                          //                                   top: 1,
                          //                                   bottom: 1))
                          //                         ]))
                          //               ]),
                          //           Spacer(),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgLocation,
                          //               height: getVerticalSize(18),
                          //               width: getHorizontalSize(21),
                          //               margin: getMargin(top: 10, bottom: 3)),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgCart,
                          //               height: getVerticalSize(20),
                          //               width: getHorizontalSize(23),
                          //               margin: getMargin(
                          //                   left: 35, top: 9, bottom: 2))
                          //         ])),
                          Padding(
                              padding: getPadding(top: 17),
                              child: Divider(
                                  height: getVerticalSize(5),
                                  thickness: getVerticalSize(5),
                                  color: ColorConstant.purple50))
                        ])))));
  }

  onTapArrowleft15() {
    Get.back();
  }

  onTapSearch() {
    Get.toNamed(AppRoutes.searchScreen);
  }

  onTapWishlist() {
    Get.toNamed(AppRoutes.whislistScreen);
  }
}
