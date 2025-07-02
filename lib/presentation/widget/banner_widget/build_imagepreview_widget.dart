
import 'dart:io';

import 'package:admin/presentation/provider/bloc/pick_image/pick_image_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Widget buildImagePreview({required ImagePickerSuccess state,required double screenWidth,required double screenHeight,required int radius}) {
  final imageWidget = () {
    if (kIsWeb && state.imageBytes != null) {
      return Image.memory(
        state.imageBytes!,
        width: screenWidth,
        height: screenHeight,
        fit: screenWidth > 600 ? BoxFit.contain : BoxFit.cover,
      );
    } else if (state.imagePath != null && state.imagePath!.startsWith('http')) {
      return Image.network(
        state.imagePath!,
        width: screenWidth ,
        height: screenHeight,
        fit: BoxFit.cover,
      );
    } else if (state.imagePath != null && state.imagePath!.isNotEmpty) {
      return Image.file(
        File(state.imagePath!),
        width: screenWidth,
        height: screenHeight,
        fit: BoxFit.cover,
      );
    } else {
      return const Text("No image selected");
    }
  }();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageWidget,
    );
}
