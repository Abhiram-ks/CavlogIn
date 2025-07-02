import 'package:admin/core/common/snackbar_helper.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/imageUpload/image_upload_bloc.dart';
import 'package:admin/presentation/provider/bloc/pick_image/pick_image_bloc.dart';
import 'package:admin/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void handleImagUploadState(BuildContext context, ImageUploadState state) {
  final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is ImageUploadError) {
    buttonCubit.stopLoading();
    CustomeSnackBar.show(
      context: context,
      title: 'Image Upload Failed',
      description: "The image upload process failed due to the following error: ${state.error}. Please try again.",
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.cloud_upload,
    );
  }else if(state is ImageUploadSuccess){
   buttonCubit.stopLoading();
   context.read<PickImageBloc>().add(ClearImageAction());
    CustomeSnackBar.show(
      context: context,
      title: 'Image Upload Successful',
     description: "The banner upload process has been completed successfully. The image upload is now complete.",
      iconColor: AppPalette.greenClr,
      icon: CupertinoIcons.cloud_upload,
    );
  } else if (state is ImageUploadLoading) {
    buttonCubit.startLoading();
  }
}