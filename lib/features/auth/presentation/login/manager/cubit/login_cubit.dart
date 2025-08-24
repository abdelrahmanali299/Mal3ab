import 'package:bloc/bloc.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;
  Future<void> loginUSer(String userName, password) async {
    emit(LoginLooding());
    final result = await authRepo.login(userName, password);

    result.fold(
      (failure) {
        emit(LoginFailure(errMessage: failure.message));
      },
      (user) {
        emit(LoginSuccess());
      },
    );
  }
}
