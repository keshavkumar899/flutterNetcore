import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/utils/color_constant.dart';
import 'package:keshav_s_application2/core/utils/image_constant.dart';
import 'package:keshav_s_application2/core/utils/size_utils.dart';
import 'package:keshav_s_application2/theme/app_style.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_image_view.dart';

class ResetPassword extends StatefulWidget {

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController newpasswordController=TextEditingController();
  TextEditingController confirmpasswordController=TextEditingController();
  bool _isObscure = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: getPadding(top: 27, bottom: 27),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                              svgPath: ImageConstant.imgClosesvgrepocom,
                              height: getSize(18),
                              width: getSize(18),
                              alignment: Alignment.centerLeft,
                              margin: getMargin(left: 24, top: 2),
                              onTap: () {
                              Navigator.pop(context);
                              }),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(top: 47),
                                  child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: getVerticalSize(16),
                                            width: getHorizontalSize(21),
                                            margin:
                                            getMargin(top: 1, bottom: 4),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.purple900,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                    Radius.circular(
                                                        getHorizontalSize(
                                                            30))))),
                                        Padding(
                                            padding: getPadding(left: 6),
                                            child: Text("Reset Password",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                AppStyle.txtRobotoMedium18))
                                      ]))),
                          SizedBox(height: 8.h,),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: newpasswordController,
                              hintText: "Enter New password",
                              margin: getMargin(left: 27, top: 18, right: 26),
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              // suffix: InkWell(
                              //     onTap: () {
                              //       newpasswordController._isObscure =
                              //       !controller.isShowPassword.value;
                              //     },
                              //     child: Container(
                              //         margin: getMargin(
                              //             left: 30,
                              //             top: 1,
                              //             right: 7,
                              //             bottom: 5),
                              //         // decoration: BoxDecoration(
                              //         //     color: ColorConstant.purple900),
                              //         child: CustomImageView(
                              //             svgPath: controller
                              //                 .isShowPassword.value
                              //                 ? ImageConstant.imgContrast
                              //                 : ImageConstant.imgContrast))),
                              suffix: IconButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ColorConstant.purple700,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              suffixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(20)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the password';
                                }
                                return null;
                              },
                              isObscureText: !_isObscure,
                              // isObscureText: !is
                          ),
                          SizedBox(height: 1.h,),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: confirmpasswordController,
                            hintText: "Confirm Password",
                            margin: getMargin(left: 27, top: 18, right: 26,bottom: 10),
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the password';
                              }
                              return null;
                            },
                          ),
                          CustomButton(
                              height: getVerticalSize(39),
                              text: "SEND OTP",
                              margin: getMargin(left: 27, top: 24, right: 26),
                              variant: ButtonVariant.FillPurple900,
                              padding: ButtonPadding.PaddingAll11,
                              fontStyle: ButtonFontStyle.RobotoMedium14,
                              onTap: (){

                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("OTP will be sent to your Registered Mobile Number & Email Address",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400),),
                          ),
                          SizedBox(height: 44.h,),
                          CustomImageView(
                              imagePath: ImageConstant.imgFinallogo03,
                              height: getVerticalSize(32),
                              width: getHorizontalSize(106),
                              margin: getMargin(top: 39))
                        ])))));
  }
}
