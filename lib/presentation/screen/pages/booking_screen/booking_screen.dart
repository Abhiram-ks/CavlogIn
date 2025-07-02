
import 'package:admin/core/common/custom_appbar.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/widget/booking_widget/booking_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/fetch_booking_repo.dart';
import '../../../provider/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>FetchBookingBloc(FetchBookingRepositoryImpl()),
      child: LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return ColoredBox(
          color: AppPalette.hintClr,
          child: SafeArea(
              child: Scaffold(
            appBar: CustomAppBar(),
            body: BookingBodyWidget(
                screenWidth: screenWidth, screenHeight: screenHeight),
          )),
        );
      }),
    );
  }
}
