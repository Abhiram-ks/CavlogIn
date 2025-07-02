import 'package:admin/core/common/alertbox_helper.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/fetchbannerbarber/fetch_banner_barber_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetchuserbanner/fetch_user_banner_bloc.dart';
import 'package:admin/presentation/provider/bloc/imagedeletion/image_deletion_bloc.dart';
import 'package:admin/presentation/widget/banner_widget/carousel_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../core/themes/colors.dart';

class FetchBannerBuildWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const FetchBannerBuildWidget(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageDeletionBloc, ImageDeletionState>(
      listener: (context, state) {
        if (state is ShowAlertConfirmation) {
          BottomSheetHelper().showBottomSheet(
              context: context,
              title: 'Banner Deletion Confirmation',
              description:
                  "Confirm deletion? This action is irreversible, and the Banner will be permanently removed from the database.",
              firstButtonText: 'Allow',
              firstButtonAction: () {
                context.read<ImageDeletionBloc>().add(ImageDeletionConfirm());
                Navigator.pop(context);
              },
              firstButtonColor: AppPalette.redClr,
              secondButtonText: "Don't Allow",
              secondButtonAction: () {
                Navigator.pop(context);
              },
              secondButtonColor: AppPalette.blackClr);
        }
      },
      child: Column(
        children: [
          Text(
            "Delete on long press of the image.",
            style: TextStyle(color: AppPalette.greyClr),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          BlocBuilder<FetchUserBannerBloc, FetchUserBannerState>(
            builder: (context, state) {
              if (state is FetchUserBannerLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstantWidgets.hight30(context),
                      SpinKitCircle(color: AppPalette.mainClr),
                      ConstantWidgets.hight10(context),
                      Text('Just a moment...'),
                      Text('Please wait while we process your request'),
                    ],
                  ),
                );
              } else if (state is UserBannerLoadedState) {
                if (state.userBanner.imageUrls.isEmpty) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstantWidgets.hight30(context),
                        Icon(
                          Icons.cloud_off_outlined,
                          size: 50,
                          color: AppPalette.blackClr,
                        ),
                        Text("Oops! There's nothing here yet."),
                        Text('No services added yet — time to take action!'),
                      ],
                    ),
                  );
                } else {
                  return BannerBuilderWidget(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    title: "User-Pannel",
                    imageWidgets: state.userBanner.imageUrls,
                    number: 1,
                    onDoubleTap: (url, number, imageIndex) {
                      context.read<ImageDeletionBloc>().add(ImageDeletionAction(
                          imageUrl: url, index: 1, imageIndex: imageIndex));
                    },
                  );
                }
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstantWidgets.hight30(context),
                    Icon(
                      Icons.cloud_off_outlined,
                      color: AppPalette.blackClr,
                      size: 50,
                    ),
                    Text("Oop's Unable to complete the request."),
                    Text('Please try again later.'),
                    IconButton(
                        onPressed: () {
                          context
                              .read<FetchUserBannerBloc>()
                              .add(FetchUserBannerAction());
                        },
                        icon: Icon(Icons.refresh_rounded))
                  ],
                ),
              );
            },
          ),
          ConstantWidgets.hight10(context),
          BlocBuilder<FetchBannerBarberBloc, FetchBannerBarberState>(
            builder: (context, state) {
              if (state is FetchBarberBannerLoading) {
               return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstantWidgets.hight30(context),
                      SpinKitCircle(color: AppPalette.mainClr),
                      ConstantWidgets.hight10(context),
                      Text('Just a moment...'),
                      Text('Please wait while we process your request'),
                    ],
                  ),
                );
              } else if (state is BarberBannerLoadedState) {
                if (state.barberBanner.imageUrls.isEmpty) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstantWidgets.hight30(context),
                        Icon(
                          Icons.cloud_off_outlined,
                          size: 50,
                          color: AppPalette.blackClr,
                        ),
                        Text("Oops! There's nothing here yet."),
                        Text('No services added yet — time to take action!'),
                      ],
                    ),
                  );
                } else {
                  return BannerBuilderWidget(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      title: "Barber-Pannel",
                      number: 2,
                      onDoubleTap: (url, number, imageIndex) {
                        context.read<ImageDeletionBloc>().add(
                            ImageDeletionAction(
                                imageUrl: url,
                                index: 2,
                                imageIndex: imageIndex));
                      },
                      imageWidgets: state.barberBanner.imageUrls);
                }
              } return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstantWidgets.hight30(context),
                    Icon(
                      Icons.cloud_off_outlined,
                      color: AppPalette.blackClr,
                      size: 50,
                    ),
                    Text("Oop's Unable to complete the request."),
                    Text('Please try again later.'),
                    IconButton(
                        onPressed: () {
                          context
                              .read<FetchBannerBarberBloc>()
                              .add(FetchBarberBannerAction());
                        },
                        icon: Icon(Icons.refresh_rounded))
                  ],
                ),
              );
            },
          ),
          ConstantWidgets.hight30(context),
        ],
      ),
    );
  }
}
