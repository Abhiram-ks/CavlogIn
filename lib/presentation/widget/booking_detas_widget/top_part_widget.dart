import 'dart:ui';

import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/fetch_barberwith_id_bloc/fetch_barberwith_id_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetch_user_bloc/fetch_user_bloc.dart';
import 'package:admin/presentation/widget/booking_detas_widget/profile_card_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/images/app_images.dart';

class PaymentTopPortion extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final String barberID;
  final String userID;
  const PaymentTopPortion(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.barberID,
      required this.userID});

  @override
  State<PaymentTopPortion> createState() => _PaymentTopPortionState();
}

class _PaymentTopPortionState extends State<PaymentTopPortion> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<FetchBarberwithIdBloc>()
          .add(FetchBarberDetailsAction(widget.barberID));
      context
          .read<FetchUserBloc>()
          .add(FetchUserRequest(userId: widget.userID));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: BlocBuilder<FetchBarberwithIdBloc, FetchBarberIdState>(
          builder: (context, state) {
            if (state is FetchBarberDetailsSuccess) {
              final barber = state.barber;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shop Details'),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Container(
                        height: widget.screenHeight * 0.13,
                        width: widget.screenWidth * 0.77,
                        color:
                            AppPalette.hintClr.withAlpha((0.27 * 255).toInt()),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {},
                          child: paymentSectionBarberData(
                              context: context,
                              imageURl:  barber.image ?? AppImages.loginImageAbove,
                              shopName: barber.ventureName,
                              shopAddress: barber.address,
                              ratings: barber.rating ?? 0,
                              screenHeight: widget.screenHeight,
                              screenWidth: widget.screenWidth),
                        ),
                      )),
                ],
              );
            }
            return Shimmer.fromColors(
                baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                highlightColor: AppPalette.whiteClr,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        height: widget.screenHeight * 0.13,
                        width: widget.screenWidth * 0.77,
                        color:
                            AppPalette.hintClr.withAlpha((0.5 * 255).toInt()),
                        alignment: Alignment.center,
                        child: paymentSectionBarberData(
                            context: context,
                            imageURl: AppImages.loginImageAbove,
                            shopName: 'Shop Name Loading...',
                            shopAddress: 'Shop Address Loading...',
                            ratings: 3,
                            screenHeight: widget.screenHeight,
                            screenWidth: widget.screenWidth),
                      ),
                    )));
          },
        )),
        ConstantWidgets.hight10(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_upward_sharp,
              color: AppPalette.blackClr,
            ),
            Icon(
              Icons.arrow_downward_sharp,
              color: AppPalette.blackClr,
            )
          ],
        ),
        ConstantWidgets.hight10(context),
        Center(child: BlocBuilder<FetchUserBloc, FetchUserState>(
            builder: (context, state) {
          if (state is FetchUserLoaded) {
            final user = state.users;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Details'),
                ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      height: widget.screenHeight * 0.13,
                      width: widget.screenWidth * 0.77,
                      color: AppPalette.hintClr.withAlpha((0.27 * 255).toInt()),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {},
                        child: paymentSectionBarberData(
                            context: context,
                            imageURl: user.image ?? AppImages.loginImageAbove,
                            shopName: user.userName ?? 'Name not available',
                            shopAddress: user.address ??
                                'No address information available at this time',
                            ratingShow: false,
                            emailID: user.email,
                            screenHeight: widget.screenHeight,
                            screenWidth: widget.screenWidth),
                      ),
                    )),
              ],
            );
          }
          return Shimmer.fromColors(
              baseColor: Colors.grey[300] ?? AppPalette.greyClr,
              highlightColor: AppPalette.whiteClr,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      height: widget.screenHeight * 0.13,
                      width: widget.screenWidth * 0.77,
                      color: AppPalette.hintClr.withAlpha((0.5 * 255).toInt()),
                      alignment: Alignment.center,
                      child: paymentSectionBarberData(
                          context: context,
                          imageURl: AppImages.loginImageAbove,
                          shopName: 'Name not available',
                          shopAddress:
                              'No address information available at this time',
                          ratingShow: false,
                          emailID: 'userxyz@gmail.com',
                          screenHeight: widget.screenHeight,
                          screenWidth: widget.screenWidth),
                    ),
                  )));
        }))
      ],
    );
  }
}
