part of 'pick_image_bloc.dart';

sealed class PickImageState{}

final class PickImageInitial extends PickImageState {}
final class ImagePickerLoading extends PickImageState {}

final class ImagePickerSuccess extends PickImageState {
  final String? imagePath;   
  final Uint8List? imageBytes;  
  ImagePickerSuccess({this.imagePath, this.imageBytes});
}

final class ImagePickerError  extends PickImageState {
  final String errorMessage;
  ImagePickerError (this.errorMessage);
}
