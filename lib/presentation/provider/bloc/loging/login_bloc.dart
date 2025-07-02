
// import 'package:admin/data/datasources/authentication/auth_remote_data_source.dart';
import 'package:admin/domain/useCase/login_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
 // final AuthRemoteDataSource admin = AuthRemoteDataSource();
  LoginBloc(this.loginUsecase) : super(LoginInitial()) {
    on<LoginActionEvent>((event, emit) async{
      emit(LodingState());
      
      try{
     //  await admin.storeAdminCredentials();
        bool isAuthenticated = await loginUsecase.execute(event.email, event.password);
        if (isAuthenticated) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs .setBool('isAdminLog', true);
          emit(LoginSuccess());
        } else {
          emit(LoginFiled(error: 'Incorrect Email or Password.'));
        }
      }catch (e){
        emit(LoginFiled(error: 'Login failed: $e'));
      }
    });
  }
}
