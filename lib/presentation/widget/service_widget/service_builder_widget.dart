import 'package:admin/presentation/widget/service_widget/handle_service_state.dart';
import 'package:admin/presentation/widget/service_widget/service_tags_widget.dart';
import 'package:admin/presentation/widget/service_widget/upload_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../provider/bloc/fetching_service/fetching_service_bloc.dart';
import '../../provider/bloc/service_management/service_mangement_bloc.dart';

class ServiceBuilderWidget extends StatelessWidget {
  const ServiceBuilderWidget({
    super.key,
    required this.widget,
  });

  final UploadServicesWidget widget;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceMangementBloc, ServiceMangementState>(
        listener: (context, state) {
      handSeviceState(context, state);
    }, child: BlocBuilder<FetchingServiceBloc, FetchingServiceState>(
      builder: (context, state) {
        if (state is FetchingServiceInitial) {
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
        } else if (state is ServiceEmptyState) {
             return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidgets.hight50(context),
              Icon(Icons.cloud_off_outlined,color: AppPalette.blackClr,size:  50,),
              Text("Oops! There's nothing here yet.",style: TextStyle(fontWeight: FontWeight.bold),),
              Text('No services added yet — time to take action!'),
            ],
          ),
        );
        }
         else if (state is ServiceLoadedState) {
          return Wrap(
              spacing: 4,
              runSpacing: 5,
              children: state.services.map((service) {
                return ServiceTagsWidget(
                    text: service.serviceName,
                    edit: () {
                      context.read<ServiceMangementBloc>().add(EditServiceEvent(serviceId: service.serviceId, serviceName: service.serviceName));
                    },
                    delete: () {
                      context.read<ServiceMangementBloc>().add(DeleteServiceEvent(service.serviceId));
                    });
              }).toList());
        } 
                    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidgets.hight50(context),
              Icon(Icons.cloud_off_outlined,color: AppPalette.blackClr,size:  50,),
              Text("Oop's Unable to complete the request."),
              Text('Please try again later.'),
              IconButton(onPressed: (){
                context.read<FetchingServiceBloc>().add(FetchServiceDataEvent());
              }, 
              icon: Icon(Icons.refresh_rounded))
            ],
          ),
        );
      },
    ));
  }
}
