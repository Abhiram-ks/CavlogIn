import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/fetchbarbers/fetch_barbers_bloc.dart';
import 'package:admin/presentation/provider/bloc/requstbox/requstbox_bloc.dart';
import 'package:admin/presentation/widget/manage_barbers_widget/requests/handle_requst_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/common/detailed_common_card.dart';
import '../../../../core/common/lottie_widget.dart';
import '../../../../core/utils/images/app_images.dart';

class RequstBlocBuilder extends StatelessWidget {
  const RequstBlocBuilder({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequstboxBloc, RequstboxState>(
      listener: (context, state) {
        handRequsetState(context, state);
      },
      child: BlocBuilder<FetchBarbersBloc, FetchBarbersState>(
        builder: (context, state) {
          if (state is FetchBarbersInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitCircle(color: AppPalette.mainClr),
                  ConstantWidgets.hight10(context),
                  Text('Just a moment...'),
                  Text('Please wait while we process your request'),
                ],
              ),
            );
          } else if (State is BarberEmptyState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottiefilesCommon(
                      assetPath: AppLottieImages.emptyData,
                      width: screenWidth * .3,
                      height: screenHeight * .3),
                  Text("Oops! There's nothing here yet."),
                  Text('No services added yet — time to take action!'),
                ],
              ),
            );
          } else if (state is BarberLoadedState) {
            final registedBarbers = state.barbers
                .where((barber) => barber.isVerified == false)
                .toList();
            if (registedBarbers.isEmpty) {
                         return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottiefilesCommon(
                      assetPath: AppLottieImages.emptyData,
                      width: screenWidth * .3,
                      height: screenHeight * .3),
                  Text("Oops! There's nothing here yet."),
                Text('No services added yet — time to take action!'),
                ],
              ),
            );
            }
            return ListView.separated(
              itemCount: registedBarbers.length,
              itemBuilder: (context, index) {
                final barber = registedBarbers[index];
                return RequestCardWidget(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  barbername: barber.barberName,
                  emailId: barber.email,
                  phoneNumber: barber.phoneNumber,
                  address: barber.address,
                  postive: 'Accept',
                  onPostive: () {
                    context.read<RequstboxBloc>().add(AcceptAction(
                        barberName: barber.barberName,
                        uid: barber.uid,
                        email: barber.email,
                        ventureName: barber.ventureName));
                  },
                  negative: 'Reject',
                  onNegative: () {
                    context.read<RequstboxBloc>().add(RejectAction(
                        barbername: barber.barberName,
                        uid: barber.uid,
                        email: barber.email,
                        ventureName: barber.ventureName));
                  },
                  imagePath: barber.image ?? '',
                  time: barber.createdAt != null
                      ? '${barber.createdAt!.hour}:${barber.createdAt!.minute} ${barber.createdAt!.hour > 12 ? "PM" : "AM"}'
                      : 'N/A',
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 6,
              ),
            );
          } else if (state is BarberErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }
                             return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off_outlined,color: AppPalette.blackClr,size:  50,),
              Text("Oop's Unable to complete the request."),
              Text('Please try again later.'),
              IconButton(onPressed: (){
                context.read<FetchBarbersBloc>().add(FetchBarbersDataEvent());
              }, 
              icon: Icon(Icons.refresh_rounded))
            ],
          ),
        );
        },
      ),
    );
  }
}
