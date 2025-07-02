
import 'package:admin/domain/useCase/data_listing_usecase.dart';
import 'package:admin/presentation/widget/booking_detas_widget/booking_details_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/models/booking_model.dart';

class MyBookingDetailsScreenListsWidget extends StatelessWidget {
  final double screenWidth;
  final BookingModel model;
  final double screenHight;
  const MyBookingDetailsScreenListsWidget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline =
        model.paymentMethod.toLowerCase().contains('online banking');
    final double totalServiceAmount =
        model.serviceType.values.fold(0.0, (sum, value) => sum + value);
    final double platformFee = calculatePlatformFee(totalServiceAmount);
    return MyBookingDetailsPortionWidget(
        screenWidth: screenWidth,
        screenHight: screenHight,
        model: model,
        isOnline: isOnline,
        platformFee: platformFee);
  }
}


