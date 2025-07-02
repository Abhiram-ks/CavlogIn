import 'package:admin/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/routes.dart';
import '../../../core/themes/colors.dart';
import '../../provider/bloc/loging/login_bloc.dart';

void handleLoginState(BuildContext context, LoginState state,TextEditingController emailController, TextEditingController passwordController) {
  final buttonCubit = context.read<ButtonProgressCubit>();
   final loginBloc = context.read<LoginBloc>();
  if (state is LodingState) {
    buttonCubit.startLoading();
  }
  else if (state is LoginSuccess) {
    buttonCubit.stopLoading();
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }else if (state is LoginFiled) {
     buttonCubit.stopLoading();

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text('Login Failed'),
      content: Text('Something went wrong. Please try again.'),
      actions: [
        CupertinoDialogAction(
          child: Text('Retry',style: TextStyle(color: AppPalette.redClr)),
          onPressed: () {
            Navigator.of(context).pop();
          loginBloc.add(LoginActionEvent(email: emailController.text.trim(), password: passwordController.text.trim()));
          },
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',style: TextStyle(color: AppPalette.whiteClr),),
        ),
      ],
    ),
  );
  }
}