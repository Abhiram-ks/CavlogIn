
import 'package:admin/core/cloudinary/cloudinary_service.dart';
import 'package:admin/data/datasources/store_imageservice/firestore_image_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../domain/useCase/imageupload_cloud_usecase.dart';

part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  final FirestoreImageService _firestoreImageService;
  final CloudinaryService _cloudinaryService;
  final ImageUploader _repo;
  ImageUploadBloc(this._firestoreImageService, this._cloudinaryService, this._repo) : super(ImageUploadInitial()) {
    on<ImageUploadRequested>((event, emit) async{
     emit(ImageUploadLoading());
      try { 
        String? response;
        if (kIsWeb && event.imageBytes != null) {
          response = await _cloudinaryService.uploadWebImage(event.imageBytes!);
        }else {
          response = await _repo.upload(event.imagePath);
        }
        if (response == null) {
          emit(ImageUploadError('Failed to upload image to Cloudinary'));
          return;
        }
        final success  = await _firestoreImageService.selectionSlot(response, event.index);
        if(success){  
          emit(ImageUploadSuccess());
        }else{
          emit(ImageUploadError('Failed to Upload Image'));
        }
      } catch (e) {
         emit(ImageUploadError('Failed: $e'));
      }
    });
  }
}
