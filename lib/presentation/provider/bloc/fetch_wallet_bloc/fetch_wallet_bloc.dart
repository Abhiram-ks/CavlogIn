import 'package:admin/data/models/wallet_model.dart';
import 'package:admin/data/repositories/fetch_admin_wallet_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'fetch_wallet_event.dart';
part 'fetch_wallet_state.dart';

class FetchWalletBloc extends Bloc<FetchWalletEvent, FetchWalletState> {
  final FetchAdminWalletRepository _repo;
  FetchWalletBloc(this._repo) : super(FetchWalletInitial()) {
    on<FetchWalletEventRequest>(_onFetchWalletEventRequest);
  }


  Future<void> _onFetchWalletEventRequest(
    FetchWalletEventRequest event,
    Emitter<FetchWalletState> emit,
  ) async {
    emit(FetchWalletLoading());
    try {
      await emit.forEach<WalletModel>(
        _repo.fetchWalletData(),
        onData: (data){
           return FetchWalletLoaded(data);
        }, 
        onError: (error, stackTrace) {
          return FetchWlletFilure('Could not load wallet data. Please try again later.');
        },
      );
    } catch (e) {
      emit(FetchWlletFilure('An unexpected error occurred. Please check your connection.'));
    }
  }
}


