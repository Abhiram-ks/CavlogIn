import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/fetch_specific_booking_bloc/fetch_specific_booking_bloc.dart';
import 'package:admin/presentation/widget/booking_detas_widget/booking_bottom_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookingDetailWidgets extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final String userId;
  final String bookingId;
  const BookingDetailWidgets(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.userId,
      required this.bookingId});

  @override
  State<BookingDetailWidgets> createState() => _BookingDetailWidgetsState();
}

class _BookingDetailWidgetsState extends State<BookingDetailWidgets> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<FetchSpecificBookingBloc>()
          .add(FetchSpecificBookingRequest(docId: widget.bookingId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSpecificBookingBloc, FetchSpecificBookingState>(
      builder: (context, state) {
        if (state is FetchSpecificBookingLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstantWidgets.hight50(context),
                SpinKitCircle(color: AppPalette.mainClr),
                ConstantWidgets.hight10(context),
                Text('Just a moment...'),
                Text('Please wait while we process your request'),
              ],
            ),
          );
        }
        else if (state is FetchSpecificBookingLoaded) {
          return MyBookingDetailsScreenListsWidget(
            screenHight: widget.screenHeight,
            screenWidth: widget.screenWidth,
            model: state.booking,
          );
        }
        return Container(
          width: widget.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: AppPalette.whiteClr),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstantWidgets.hight50(context),
              Icon(Icons.cloud_off_outlined,color: AppPalette.blackClr,size:  50,),
              ConstantWidgets.hight10(context),
              Text("Oop's Unable to complete the request."),
              Text('Please try again later.'),
              IconButton(
                  onPressed: () {
                    context.read<FetchSpecificBookingBloc>().add(
                        FetchSpecificBookingRequest(docId: widget.bookingId));
                  },
                  icon: Icon(Icons.refresh_rounded))
            ],
          ),
        );
      },
    );
  }
}
