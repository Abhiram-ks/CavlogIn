
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:admin/presentation/widget/booking_widget/booking_custom_filter_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MybookingFilteringCards extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const MybookingFilteringCards({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.048,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            BookingFilteringCards(
              label: 'All Booking',
              icon: Icons.history_rounded,
              colors: Colors.black,
              onTap: () {
                context.read<FetchBookingBloc>().add(FetchBookingDatsRequest());
              },
            ),
            VerticalDivider(color: AppPalette.hintClr),
            BookingFilteringCards(
              label: 'Completed',
              icon: Icons.check_circle_outline_sharp,
              colors: Colors.green,
              onTap: () {
               context.read<FetchBookingBloc>().add(FetchBookingDatasFilteringStatus(status: 'Completed'));
              },
            ),
            VerticalDivider(color: AppPalette.hintClr),
            BookingFilteringCards(
              label: 'Cancelled',
              icon: Icons.free_cancellation_rounded,
              colors: AppPalette.redClr,
              onTap: () {
                 context.read<FetchBookingBloc>().add(FetchBookingDatasFilteringStatus(status: 'Cancelled'));
              },
            ),
            VerticalDivider(color: AppPalette.hintClr),
            BookingFilteringCards(
              label: 'Pending',
              icon: Icons.pending_actions_rounded,
              colors: AppPalette.mainClr,
              onTap: () {
                context.read<FetchBookingBloc>().add(FetchBookingDatasFilteringStatus(status: 'Pending'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
