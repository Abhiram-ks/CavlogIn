import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:admin/presentation/widget/wallet_widget/wallet_card_builder_widget.dart';
import 'package:admin/presentation/widget/wallet_widget/wallet_custom_filterbutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTransctionWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const WalletTransctionWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal:screenWidth > 600 ? screenWidth*.2  : screenWidth * 0.03),
          child: SizedBox(
            height: screenHeight * 0.04,
            child: Row(
              children: [
                WalletFilterButton(
                  label: 'All Transfers',
                  icon: Icons.swap_horiz,
                  colors: AppPalette.blackClr,
                  onTap: () {
                   context.read<FetchBookingBloc>().add(FetchBookingDatsRequest());
                  }
                ),
                VerticalDivider(color: AppPalette.hintClr),
                WalletFilterButton(
                  label: 'Via Online',
                  icon: Icons.arrow_upward_rounded,
                  colors: AppPalette.greenClr,
                  onTap: () {
                    context.read<FetchBookingBloc>().add(
                      FetchBookingDatasFilteringTransaction(
                          fillterText: "Online Banking"));
                  }
                ),
                VerticalDivider(color: AppPalette.hintClr),
                WalletFilterButton(
                    label: 'Via Wallet',
                    colors: AppPalette.mainClr       ,
                    icon: Icons.arrow_upward_rounded,
                    onTap: () {
                     context.read<FetchBookingBloc>().add(
                        FetchBookingDatasFilteringTransaction(
                            fillterText: "Digital money / Wallet")
                        );
                    }
                    ),
                    
  
              ],
            ),
          ),
        ),
        ConstantWidgets.hight20(context),
        Expanded( child: walletTransactionWidgetBuilder(context, screenHeight, screenWidth))
      ],
    );
  }
}



