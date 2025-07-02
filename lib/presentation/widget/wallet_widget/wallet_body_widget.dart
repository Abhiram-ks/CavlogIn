
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetch_wallet_bloc/fetch_wallet_bloc.dart';
import 'package:admin/presentation/widget/wallet_widget/wallet_filter_card_widget.dart';
import 'package:admin/presentation/widget/wallet_widget/wallet_overview_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreenWidget extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  const WalletScreenWidget(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<WalletScreenWidget> createState() => _WalletScreenWidgetState();
}

class _WalletScreenWidgetState extends State<WalletScreenWidget> {
    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchWalletBloc>().add(FetchWalletEventRequest());
      context.read<FetchBookingBloc>().add(FetchBookingDatsRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal:widget.screenWidth > 600 ? widget.screenWidth *.2 : widget.screenWidth * .06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Digital Wallet',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 28, fontWeight: FontWeight.bold)),
              ConstantWidgets.hight10(context),
              Text(
                'Effortlessly oversee all wallet activities — monitor transactions, manage user top-ups, and ensure up-to-date payment tracking with powerful admin insights.',
              ),
            ],
          ),
        ),
        WalletOverViewCard(screenWidth: widget.screenWidth, screenHeight: widget.screenHeight),
        Expanded(
          child: WalletTransctionWidget(screenWidth: widget.screenWidth, screenHeight: widget.screenHeight)
        )
      ],
    );
  }
}



