part of 'fetch_barberwith_id_bloc.dart';

abstract class FetchBarberIdState  {
}

final class FetchBarberIdInitial extends FetchBarberIdState {}


final class FetchBarberDetailsLoading extends FetchBarberIdState {}
final class FetchBarberDetailsSuccess extends FetchBarberIdState {
  final BarberModel barber;
  FetchBarberDetailsSuccess(this.barber);
}

class FetchBarberDetailsFailure extends FetchBarberIdState {
  final String error;
  FetchBarberDetailsFailure(this.error);
}