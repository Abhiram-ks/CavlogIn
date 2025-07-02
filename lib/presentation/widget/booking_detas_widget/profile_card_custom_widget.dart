import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/widget/booking_detas_widget/profile_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/common_imageshow.dart';
import '../../../core/utils/images/app_images.dart';

SizedBox paymentSectionBarberData(
    {required BuildContext context,
    required String imageURl,
    required String shopName,
    bool ratingShow = true,
    String? emailID,
    required String shopAddress,
    double? ratings,
    required double screenWidth,
    required double screenHeight}) {
  return SizedBox(
    height: screenHeight * 0.12,
    child: Row(
      children: [
        ConstantWidgets.width20(context),
        Flexible(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: (imageURl.startsWith('http'))
                ? imageshow(
                    imageUrl: imageURl, imageAsset: AppImages.loginImageAbove)
                : Image.asset(
                    AppImages.loginImageAbove,
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                  ),
          ),
        ),
        ConstantWidgets.width20(context),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  shopName,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppPalette.blackClr),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                profileviewWidget(
                  screenWidth,
                  context,
                  Icons.location_on,
                  shopAddress,
                  AppPalette.redClr,
                  maxline: 2,
                  textColor: AppPalette.greyClr,
                ),
                ConstantWidgets.width40(context),
                ratingShow
                    ? RatingBarIndicator(
                        rating: ratings ?? 5,
                        unratedColor: AppPalette.greyClr,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: AppPalette.redClr,
                        ),
                        itemCount: 5,
                        itemSize: 13.0,
                        direction: Axis.horizontal,
                      )
                    : Text(
                        emailID ?? 'example@gmali.com',
                        style: TextStyle(color: AppPalette.blackClr),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
              ],
            ),
          ),
        ),
        ConstantWidgets.width20(context),
      ],
    ),
  );
}
