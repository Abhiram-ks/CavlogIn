import 'package:admin/data/repositories/fetch_user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
part 'fetch_user_event.dart';
part 'fetch_user_state.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  final FetchUserRepository _repo;
  FetchUserBloc(this._repo) : super(FetchUserInitial()) {
     on<FetchUserRequest>(_onFetchUserDetailsRequest);
  }
  
  Future<void> _onFetchUserDetailsRequest(
    FetchUserRequest event,
    Emitter<FetchUserState> emit,
  ) async {
    emit(FatchUserLoading()); 
    await emit.forEach<UserModel?>(
      _repo.streamUserData(event.userId),
      onData: (user) {
        if (user != null) {
          return FetchUserLoaded(users: user);
        } else {
          return  FetchUserFailure();
        }
      },
      onError: (error, _) => FetchUserFailure(),
    );
  }
}
