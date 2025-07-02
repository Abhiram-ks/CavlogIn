
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../provider/bloc/fetch_wallet_bloc/fetch_wallet_bloc.dart';
import 'wallet_custom_card_widget.dart';

class WalletOverViewCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const WalletOverViewCard(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.15,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:screenWidth > 600 ? screenWidth* .2 : screenWidth * 0.05),
        child: Column(
          children: [
            ConstantWidgets.hight10(context),
            BlocBuilder<FetchWalletBloc, FetchWalletState>(
              builder: (context, state) {
                if (state is FetchWalletLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                    highlightColor: AppPalette.whiteClr,
                    child: walletBalanceWidget(
                      iconColor: AppPalette.greyClr,
                      context: context,
                      balance: '₹ 0.00',
                      balanceColor: AppPalette.greyClr,
                    ),
                  );
                } else if (state is FetchWalletLoaded) {
                  final walletModel = state.wallet;
                  final balance = walletModel.lifeTimeAmount < 2000;

                  return walletBalanceWidget(
                    iconColor: balance ? AppPalette.redClr : AppPalette.mainClr,
                    context: context,
                    balance:
                        '₹ ${walletModel.lifeTimeAmount.toStringAsFixed(2)}',
                    balanceColor:
                        balance ? AppPalette.redClr : AppPalette.greenClr,
                  );
                }
                return walletBalanceWidget(
                    iconColor: AppPalette.mainClr,
                    context: context,
                    balance: '₹ 0.00',
                    balanceColor: AppPalette.blackClr);
              },
            ),
            ConstantWidgets.hight10(context),
          ],
        ),
      ),
    );
  }
}

