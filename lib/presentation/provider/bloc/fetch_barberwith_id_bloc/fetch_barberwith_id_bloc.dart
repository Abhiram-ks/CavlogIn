import 'package:admin/data/models/barbermodel.dart';
import 'package:admin/data/repositories/fetch_barberid_repo.dart';
import 'package:bloc/bloc.dart';
part 'fetch_barberwith_id_event.dart';
part 'fetch_barberwith_id_state.dart';

class FetchBarberwithIdBloc extends Bloc<FetchBarberIdEvent, FetchBarberIdState> {
  final FetchBarberidRepository _repo;
  FetchBarberwithIdBloc(this._repo) : super(FetchBarberIdInitial()) {
     on<FetchBarberDetailsAction>(_onFetchBarberDetailsRequest);
  }

  Future<void> _onFetchBarberDetailsRequest(
    FetchBarberDetailsAction event,
    Emitter<FetchBarberIdState> emit,
  ) async {
    emit(FetchBarberDetailsLoading());


       await emit.forEach(
      _repo.streamBarber(barberID: event.barberId),
      onData: (barber) => FetchBarberDetailsSuccess(barber),
      onError: (error, _) => FetchBarberDetailsFailure(error.toString()),
    );
  }
}
