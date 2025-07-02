import 'package:admin/core/common/custom_appbar.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/data/repositories/fetch_admin_wallet_repo.dart';
import 'package:admin/data/repositories/fetch_booking_repo.dart';
import 'package:admin/presentation/provider/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:admin/presentation/widget/wallet_widget/wallet_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../provider/bloc/fetch_wallet_bloc/fetch_wallet_bloc.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FetchWalletBloc(FetchAdminWalletRepositoryImpl())),
        BlocProvider(create: (_) => FetchBookingBloc(FetchBookingRepositoryImpl())),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return ColoredBox(
            color: AppPalette.hintClr,
            child: SafeArea(
              child: Scaffold(
                appBar: CustomAppBar(),
                body: WalletScreenWidget(
                    screenWidth: screenWidth, screenHeight: screenHeight),
              ),
            ),
          );
        },
      ),
    );
  }
}
