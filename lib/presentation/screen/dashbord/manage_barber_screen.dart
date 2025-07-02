
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/toggleview/toggleview_bloc.dart';
import 'package:admin/presentation/screen/pages/booking_screen/booking_screen.dart';
import 'package:admin/presentation/screen/pages/wallet_screen/wallet_screen.dart';
import 'package:admin/presentation/widget/home_widget/custom_switch_buttons.dart';
import 'package:admin/presentation/widget/manage_barbers_widget/barbers_status/barbers_status_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widget/manage_barbers_widget/requests/requst_bloc_builder.dart';

class ManageBarberScreen extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ManageBarberScreen({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal:screenWidth > 600 ? screenWidth * .2: screenWidth * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstantWidgets.hight10(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SearchAndFilter(icon: Icons.book,action: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                },),
                SearchAndFilter(icon: Icons.account_balance_wallet,action: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
                },),
                SearchAndFilter(icon: Icons.person_search,action: (){
                  context.read<ToggleviewBloc>().add(ToggleviewAction()); 
                },),
              ],
            ),
            ConstantWidgets.hight10(context),
            BlocBuilder<ToggleviewBloc, ToggleviewState>(
              builder: (context, state) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state is ToggleviewStatus ? 'Barbers Status' : 'Requests',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<ToggleviewBloc, ToggleviewState>(
                builder: (context, state) {
                  return state is ToggleviewStatus
                      ? BarbersStatusBuilder(
                          screenHeight: screenHeight, screenWidth: screenWidth)
                      : RequstBlocBuilder(
                          screenHeight: screenHeight, screenWidth: screenWidth);
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
