import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keshav_s_application2/core/utils/color_constant.dart';
import 'package:keshav_s_application2/core/utils/image_constant.dart';
import 'package:keshav_s_application2/core/utils/size_utils.dart';
import 'package:keshav_s_application2/presentation/ResetPassword.dart';
import 'package:keshav_s_application2/routes/app_routes.dart';
import 'package:keshav_s_application2/theme/app_style.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_image_view.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

class PasswordScreen extends StatefulWidget {
  String mobileNumber;
  PasswordScreen(this.mobileNumber);


  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          padding: getPadding(
            top: 27,
            bottom: 27,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageView(
                onTap: (){
                  Navigator.pop(context);
                },
                svgPath: ImageConstant.imgClosesvgrepocom,
                height: getSize(
                  18,
                ),
                width: getSize(
                  18,
                ),
                alignment: Alignment.centerLeft,
                margin: getMargin(
                  left: 24,
                  top: 2,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: getPadding(
                    top: 45,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: getVerticalSize(
                          16,
                        ),
                        width: getHorizontalSize(
                          21,
                        ),
                        margin: getMargin(
                          top: 3,
                          bottom: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.purple900,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                              getHorizontalSize(
                                30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 6,
                        ),
                        child: Text(
                          "Enter Password",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRobotoMedium18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: getPadding(
              //       left: 27,
              //       top: 13,
              //     ),
              //     child: Text(
              //       "msg_enter_your_4".tr,
              //       overflow: TextOverflow.ellipsis,
              //       textAlign: TextAlign.left,
              //       style: AppStyle.txtRobotoRegular12Purple700,
              //     ),
              //   ),
              // ),
              CustomTextFormField(
                focusNode: FocusNode(),
                controller: passwordController,
                hintText: "Enter Password",
                margin: getMargin(
                  left: 27,
                  top: 68,
                  right: 26,
                ),
                textInputAction: TextInputAction.done,
                suffix: Container(
                  margin: getMargin(
                    left: 12,
                    right: 11,
                    bottom: 4,
                  ),
                  // decoration: BoxDecoration(
                  //   color: ColorConstant.purple900,
                  // ),
                  child: CustomImageView(
                    svgPath: ImageConstant.imgVector,
                  ),
                ),
                suffixConstraints: BoxConstraints(
                  maxHeight: getVerticalSize(
                    26,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword()));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: getPadding(
                      top: 7,
                      right: 36,
                    ),
                    child: Text(
                      "Forgot Password?",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRobotoRegular14Blue700,
                    ),
                  ),
                ),
              ),
              CustomButton(
                onTap:(){
                  print(widget.mobileNumber);
                  print(passwordController.text);

                  FocusManager.instance.primaryFocus.unfocus();
                  passwordController.clear();
                  Get.toNamed(AppRoutes.landingScreen);
                },
                height: getVerticalSize(
                  39,
                ),
                text: "lbl_login2".tr,
                margin: getMargin(
                  left: 27,
                  top: 29,
                  right: 26,
                ),
                variant: ButtonVariant.FillPurple900,
                padding: ButtonPadding.PaddingAll11,
                fontStyle: ButtonFontStyle.RobotoMedium14,
              ),
              Spacer(),
              Text(
                "msg_or_continue_with".tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoRegular15,
              ),
              CustomImageView(
                svgPath: ImageConstant.imgGooglesvgrepocom,
                height: getSize(
                  45,
                ),
                width: getSize(
                  45,
                ),
                margin: getMargin(
                  top: 21,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgFinallogo03,
                height: getVerticalSize(
                  32,
                ),
                width: getHorizontalSize(
                  106,
                ),
                margin: getMargin(
                  top: 39,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
