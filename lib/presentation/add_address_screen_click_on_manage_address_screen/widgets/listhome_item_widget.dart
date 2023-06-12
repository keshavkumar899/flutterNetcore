import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/add_address_screen_click_on_manage_address_screen/ManageAddressModel.dart';
import 'package:keshav_s_application2/presentation/add_new_address_screen_click_on_manage_address_screen/add_new_address_screen_click_on_manage_address_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

// ignore: must_be_immutable
class ListhomeItemWidget extends StatefulWidget {
  ListhomeItemWidget(this.data,this.addressdata);
  Data data;
  AddressData addressdata;

  @override
  State<ListhomeItemWidget> createState() => _ListhomeItemWidgetState();
}

class _ListhomeItemWidgetState extends State<ListhomeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Container(
        decoration: AppDecoration.outlineBlack90019.copyWith(
          borderRadius: BorderRadiusStyle.customBorderBR50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(
                right: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomButton(
                    variant: ButtonVariant.FillPurple900,
                    height: getVerticalSize(
                      21,
                    ),
                    width: getHorizontalSize(
                      62,
                    ),
                    text: widget.addressdata.defaulted=="0"?"Home":"Office",
                    fontStyle: ButtonFontStyle.RobotoMedium12,
                    margin: getMargin(
                      bottom: 8,
                    ),
                  ),
                  Spacer(),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    margin: getMargin(
                      top: 10,
                    ),
                    color: ColorConstant.whiteA700,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: ColorConstant.purple900,
                        width: getHorizontalSize(
                          1,
                        ),
                      ),
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                    ),
                    child: Container(
                      height: getVerticalSize(
                        19,
                      ),
                      width: getHorizontalSize(
                        26,
                      ),
                      padding: getPadding(
                        left: 9,
                        top: 4,
                        right: 9,
                        bottom: 4,
                      ),
                      decoration: AppDecoration.outlinePurple9001.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder5,
                      ),
                      child: Stack(
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgTrash,
                            height: getVerticalSize(
                              11,
                            ),
                            width: getHorizontalSize(
                              8,
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: AddNewAddressScreenClickOnManageAddressScreen(widget.data,widget.addressdata),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: getMargin(
                        left: 15,
                        top: 10,
                      ),
                      color: ColorConstant.whiteA700,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorConstant.purple900,
                          width: getHorizontalSize(
                            1,
                          ),
                        ),
                        borderRadius: BorderRadiusStyle.roundedBorder5,
                      ),
                      child: Container(
                        height: getVerticalSize(
                          19,
                        ),
                        width: getHorizontalSize(
                          26,
                        ),
                        padding: getPadding(
                          left: 7,
                          top: 5,
                          right: 7,
                          bottom: 5,
                        ),
                        decoration: AppDecoration.outlinePurple9001.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder5,
                        ),
                        child: Stack(
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgEdit,
                              height: getVerticalSize(
                                9,
                              ),
                              width: getHorizontalSize(
                                10,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                left: 15,
                top: 6,
              ),
              child: Text(
                widget.addressdata.name.capitalizeFirst,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoMedium14Purple900,
              ),
            ),
            // Padding(
            //   padding: getPadding(
            //     left: 16,
            //     top: 3,
            //   ),
            //   child: Text(
            //     "87887 87887",
            //     overflow: TextOverflow.ellipsis,
            //     textAlign: TextAlign.left,
            //     style: AppStyle.txtRobotoRegular9,
            //   ),
            // ),
            Container(
              width: getHorizontalSize(
                281,
              ),
              margin: getMargin(
                left: 16,
                top: 10,
                right: 81,
                bottom: 15,
              ),
              child: Text(
                widget.addressdata.addressOne.capitalizeFirst +", "+ widget.addressdata.city +"\n" + widget.addressdata.state + " - "+widget.addressdata.pincode,
                maxLines: null,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoRegular12Gray6001,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
