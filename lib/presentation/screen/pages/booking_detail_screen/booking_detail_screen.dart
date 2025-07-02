import 'package:admin/core/common/custom_appbar.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/data/repositories/fetch_barberid_repo.dart';
import 'package:admin/data/repositories/fetch_specific_booking_repo.dart';
import 'package:admin/presentation/provider/bloc/fetch_barberwith_id_bloc/fetch_barberwith_id_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetch_user_bloc/fetch_user_bloc.dart';
import 'package:admin/presentation/widget/booking_detas_widget/booking_bottom_widget.dart';
import 'package:admin/presentation/widget/booking_detas_widget/top_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/colors.dart';
import '../../../../data/repositories/fetch_user_repo.dart';
import '../../../provider/bloc/fetch_specific_booking_bloc/fetch_specific_booking_bloc.dart';

class BookingDetailScreen extends StatelessWidget {
  final String userId;
  final String barberId;
  final String docId;
  const BookingDetailScreen(
      {super.key,
      required this.userId,
      required this.barberId,
      required this.docId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FetchBarberwithIdBloc(FetchBarberidRepositoryImpl())),
        BlocProvider(create: (_) => FetchUserBloc(FetchUserRepositoryImpl())),
        BlocProvider(create: (_) => FetchSpecificBookingBloc(FetchSpecificBookingRepositoryImpl())),
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
                backgroundColor: AppPalette.whiteClr,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? screenWidth * .2 : 0),
                    child: Column(
                      children: [
                        PaymentTopPortion(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          barberID: barberId,
                          userID: userId,
                        ),
                        ConstantWidgets.hight10(context),
                        BookingDetailWidgets(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            userId: userId,
                            bookingId: docId)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

