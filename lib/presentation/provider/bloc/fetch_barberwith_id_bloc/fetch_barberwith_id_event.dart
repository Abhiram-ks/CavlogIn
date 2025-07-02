part of 'fetch_barberwith_id_bloc.dart';

abstract class FetchBarberIdEvent {}

final class FetchBarberDetailsAction extends FetchBarberIdEvent {
  final String barberId;
  FetchBarberDetailsAction(this.barberId);
}