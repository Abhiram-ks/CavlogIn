
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:admin/presentation/widget/booking_widget/booking_builder_widget.dart';
import 'package:admin/presentation/widget/booking_widget/booking_fileter_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingBodyWidget extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  const BookingBodyWidget(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<BookingBodyWidget> createState() => _BookingBodyWidgetState();
}

class _BookingBodyWidgetState extends State<BookingBodyWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchBookingBloc>().add(FetchBookingDatsRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal:widget.screenWidth > 600 ? widget.screenWidth * .2 : widget.screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bookings',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ConstantWidgets.hight10(context),
              Text(
                  "Stay on top of your schedule by tracking the status of every booking and reviewing appointment details anytime. Gain insights with detailed analytics for each booking to help you stay organized and informed."),
              ConstantWidgets.hight20(context),
              MybookingFilteringCards(
                screenWidth: widget.screenWidth,
                screenHeight: widget.screenHeight,
              ),
              ConstantWidgets.hight20(context),
            ],
          ),
        ),
        Expanded(
            child: bookingBuilderCard(
                context, widget.screenHeight, widget.screenWidth)),
      ],
    );
  }
}