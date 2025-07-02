import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';

Row walletBalanceWidget(
    {required BuildContext context,
    required Color iconColor,
    IconData? icon,
    String? titile,
    required String balance,
    required Color balanceColor}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton.filled(
        onPressed: () {},
        icon: Icon(
          icon ?? Icons.account_balance_wallet,
          size: 40,
          color: AppPalette.whiteClr,
        ),
        style: IconButton.styleFrom(
          backgroundColor: iconColor,
          fixedSize: const Size(60, 60),
        ),
      ),
      ConstantWidgets.width40(context),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titile ?? 'Available Balance',
              style: GoogleFonts.plusJakartaSans(color: Colors.grey[600]),
            ),
            Text(
              balance,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: balanceColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
