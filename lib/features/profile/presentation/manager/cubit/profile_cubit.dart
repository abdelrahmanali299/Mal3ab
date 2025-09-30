import 'package:bloc/bloc.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/profile/data/repo/profile_repo_impl.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  @override
  void onChange(Change<ProfileState> change) {
    super.onChange(change);
  }

  ProfileCubit() : super(ProfileInitial());

  registerPlayer(UserModel userModel) async {
    emit(RegisterLoading());
    var res = await ProfileRepoImpl().register(userModel);
    res.fold(
      (failure) {
        emit(RegisterFailure(errMessage: failure.message));
      },
      (register) {
        emit(RegisterSuccess());
      },
    );
  }

  void withdraw(UserModel userModel) async {
    emit(WithdrawLoading());
    var res = await ProfileRepoImpl().withdrow(userModel);
    res.fold(
      (failure) {
        emit(WithdrawFailure(errMessage: failure.message));
      },
      (register) {
        emit(WithdrawSuccess());
      },
    );
  }

  void update(UserModel userModel) async {
    emit(UpdateLoading());
    var res = await ProfileRepoImpl().updateData(userModel);
    res.fold(
      (failure) {
        emit(UpdateFailure(errMessage: failure.message));
      },
      (register) {
        emit(UpdatewSuccess());
      },
    );
  }
}
