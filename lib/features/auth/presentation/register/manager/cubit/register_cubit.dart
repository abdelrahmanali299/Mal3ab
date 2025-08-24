import 'package:bloc/bloc.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  final AuthRepo authRepo;

  Future<void> signUp(UserModel userModel) async {
    emit(RegisterLooding());
    final result = await authRepo.signUp(userModel);
    result.fold(
      (failure) {
        emit(RegisterFailure(errMessage: failure.message));
      },
      (success) {
        emit(RegisterSuccess(userModel: userModel));
      },
    );
  }
}
