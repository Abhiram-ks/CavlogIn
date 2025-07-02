
import 'package:admin/presentation/widget/banner_widget/build_imagepreview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../core/themes/colors.dart';
import '../../provider/bloc/pick_image/pick_image_bloc.dart';

class ImagePickerWIdget extends StatelessWidget {
  const ImagePickerWIdget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: InkWell(
      onTap: () {
        context.read<PickImageBloc>().add(ImagePickerEvent());
      },
      child: DottedBorder(
        color: AppPalette.greyClr,
        strokeWidth: 1,
        dashPattern: [4, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: SizedBox(
          width: screenWidth * 0.9,
          height: screenHeight * 0.23,
          child: BlocBuilder<PickImageBloc, PickImageState>(
            builder: (context, state) {
              if (state is PickImageInitial) {
                return SizedBox(
                    width: screenWidth * 0.89,
                    height: screenHeight * 0.22,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.cloud_upload,
                          size: 35,
                          color: AppPalette.buttonClr,
                        ),
                        Text('Upload an Image')
                      ],
                    ));
              } else if (state is ImagePickerLoading) {
                return SpinKitCircle(
                  color: AppPalette.mainClr,
                );
              } else if (state is ImagePickerSuccess) {
                return buildImagePreview(state: state, screenWidth: screenWidth * 0.89, screenHeight: screenHeight * 0.2, radius: 12);
              } else if (state is ImagePickerError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.photo,
                      size: 35,
                      color: AppPalette.redClr,
                    ),
                    Text(state.errorMessage)
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.cloud_upload,
                    size: 35,
                    color: AppPalette.buttonClr,
                  ),
                  Text('Upload an Image')
                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}
