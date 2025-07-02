
import 'package:admin/data/repositories/fetch_booking_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/booking_model.dart';
part 'fetch_booking_event.dart';
part 'fetch_booking_state.dart';


class FetchBookingBloc extends Bloc<FetchBookingEvent, FetchBookingState> {
  final FetchBookingRepository _repository;
  FetchBookingBloc(this._repository)
  : super(FetchBookingInitial()) {
    on<FetchBookingDatsRequest>(_onFetchBookingDatsRequest);
    on<FetchBookingDatasFilteringTransaction>(_onFilterBookingTransaction);
    on<FetchBookingDatasFilteringStatus>(_onFilterBookingStatus);
  }

  Future<void> _onFetchBookingDatsRequest(
    FetchBookingDatsRequest event,
    Emitter<FetchBookingState> emit,
  ) async {
    emit(FetchBookingLoading());
    try {
      await emit.forEach<List<BookingModel>>(
        _repository.stramBookings(),
        onData: (bookings) {
          if (bookings.isEmpty) {
            return FetchBookingEmpty();
          } else {
            return FetchBookingSuccess(bookings: bookings);
          }
        },
        onError: (error, stackTrace) {
          return FetchBookingFailure('Could not load booking data. Please try again later.');
        },
      );
    } catch (e) {
      emit(FetchBookingFailure('An unexpected error occurred. Please check your connection.'));
    }
  }
   

  Future<void> _onFilterBookingStatus(
    FetchBookingDatasFilteringStatus event,
    Emitter<FetchBookingState> emit,
  ) async {
    emit(FetchBookingLoading());
    try {
      await emit.forEach<List<BookingModel>>(
        _repository.streamBookingsFilter(status: event.status),
        onData: (datas) {
          if (datas.isEmpty) {
            return FetchBookingEmpty();
          } else {
            return FetchBookingSuccess(bookings: datas);
          }
        },
        onError: (error, stackTrace) {
          return FetchBookingFailure('Filtering failed: $error');
        },
      );
    } catch (e) {
      emit(FetchBookingFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  
  Future<void> _onFilterBookingTransaction(
    FetchBookingDatasFilteringTransaction event,
    Emitter<FetchBookingState> emit,
  ) async {
    emit(FetchBookingLoading());
    try {
     
      await emit.forEach<List<BookingModel>>(
          _repository.streamBookingspaymentMethod(status: event.fillterText),
        onData: (datas) {

          if (datas.isEmpty) {
            return FetchBookingEmpty();
          } else {
            return FetchBookingSuccess(bookings: datas);
          }
        },
        onError: (error, stackTrace) {
          return FetchBookingFailure('Filtering failed: $error');
        },
      );
    } catch (e) {
      emit(FetchBookingFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

 
}
