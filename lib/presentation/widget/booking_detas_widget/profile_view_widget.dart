
import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:flutter/material.dart';

SizedBox profileviewWidget(double screenWidth, BuildContext context,
    IconData icons, String heading, Color iconclr,
    {Color? textColor, int? maxline, double? widget}) {
  return SizedBox(
    width: widget ?? screenWidth * 0.55,
    child: Row(children: [
      Icon(
        icons,
        color: iconclr,
      ),
      ConstantWidgets.width20(context),
      Expanded(
        child: Text(
          heading,
          style: TextStyle(
            color: textColor ?? AppPalette.whiteClr,
          ),
          maxLines: maxline ?? 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]),
  );
}
