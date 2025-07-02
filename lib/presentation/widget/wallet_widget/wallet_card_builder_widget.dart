import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:admin/presentation/screen/pages/booking_detail_screen/booking_detail_screen.dart';
import 'package:admin/presentation/widget/wallet_widget/custom_booking_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/media_quary/constant/constant.dart';
import '../../../domain/useCase/data_listing_usecase.dart';

RefreshIndicator walletTransactionWidgetBuilder(
    BuildContext context, double screenHeight, double screenWidth) {
  return RefreshIndicator(
    backgroundColor: AppPalette.whiteClr,
    color: AppPalette.buttonClr,
    onRefresh: () async {
   context.read<FetchBookingBloc>().add(FetchBookingDatsRequest());
    },
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:screenWidth > 600 ? screenWidth *.2 : screenWidth * 0.04),
        child: Column(
          children: [
            BlocBuilder<FetchBookingBloc, FetchBookingState>(
              builder: (context, state) {
                if (state is FetchBookingLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                    highlightColor: AppPalette.whiteClr,
                    child: SizedBox(
                      height: screenHeight * 0.5,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => ConstantWidgets.hight10(context),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return TrasactionCardsWalletWidget(
                            ontap: () {},
                            screenHeight: screenHeight,
                            mainColor: AppPalette.hintClr,
                            amount: '+ ₹500.00',
                            amountColor: AppPalette.greyClr,
                            status: 'Loading..',
                            statusIcon: Icons.check_circle_outline_outlined,
                            id: 'Transaction #${index + 1}',
                            stusColor: AppPalette.greyClr,
                            dateTime: DateTime.now().toString(),
                            method: 'Online Banking',
                            description:
                                "Sent: Online Banking transfer of ₹500.00",
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is FetchBookingEmpty) {
                                      return Center(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstantWidgets.hight50(context),
                          Icon(CupertinoIcons.cloud_download_fill,color: AppPalette.blackClr,),
                          Text("Oops! There's nothing here yet."),
                          Text("No transactions yet!",
                              style: TextStyle(color: AppPalette.mainClr))
                        ]),
                      );
                 } 
                else if (state is FetchBookingSuccess) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: state.bookings.length,
                    separatorBuilder: (_, __) =>
                        ConstantWidgets.hight10(context),
                    itemBuilder: (context, index) {
                      final booking = state.bookings[index];
                      final date = formatDate(booking.createdAt);
                      final time = formatTimeRange(booking.createdAt);
                      final val = amount(booking.amountPaid);
                      final iscredited = booking.transaction.toLowerCase().contains('debited');
                      final isOnline = booking.paymentMethod.toLowerCase().contains('online banking');
                      return TrasactionCardsWalletWidget(
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailScreen(userId: booking.userId, barberId: booking.barberId, docId: booking.bookingId ?? '')));
                        },
                        screenHeight: screenHeight,
                        amount: iscredited
                            ? '+ ₹$val'
                            : '+ ₹$val',
                        amountColor: iscredited
                            ? AppPalette.greenClr
                            : const Color.fromRGBO(255, 103, 92, 1),
                        dateTime:'$date At $time',
                        description: 'Recived ${booking.paymentMethod} transfer of ₹$val',
                        id: isOnline
                            ? 'Id: Paid via Online Banking - No id Availbale'
                            : 'Paid via wallet - No id available',
                        method: 'Method: ${booking.paymentMethod}',
                        status: booking.status,
                        statusIcon: booking.status.toLowerCase() == 'completed'
                            ? Icons.check_circle_outline_outlined
                            : Icons.timelapse,
                        stusColor: booking.status.toLowerCase() == 'completed'
                            ? AppPalette.greenClr
                            : AppPalette.buttonClr,
                      );
                    },
                  );
                }
                return Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstantWidgets.hight50(context),
                        Icon(CupertinoIcons.cloud_download_fill,color: AppPalette.blackClr,),
                         Text("Oop's Unable to complete the request."),
                        Text('Please try again later.'),
                        IconButton(onPressed: (){
                          context.read<FetchBookingBloc>().add(FetchBookingDatsRequest());
                        },
                        icon: Icon(Icons.refresh_rounded))
                      ]),
                );

              },
            ),
            ConstantWidgets.hight20(context)
          ],
        ),
      ),
    ),
  );
}

