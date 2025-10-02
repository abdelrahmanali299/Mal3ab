import 'package:bloc/bloc.dart';
import 'package:mal3ab/constants.dart';
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

  registerPlayer(String mainId, Map<String, dynamic> data) async {
    emit(RegisterLoading());
    var res = await ProfileRepoImpl().updateData(
      mainId: mainId,
      collection: kMatchesCollection,
      data: data,
    );

    res.fold(
      (failure) {
        emit(RegisterFailure(errMessage: failure.message));
      },
      (register) async {
        emit(RegisterSuccess());
      },
    );
  }

  void withdraw(String mainId, Map<String, dynamic> data) async {
    emit(WithdrawLoading());
    var res = await ProfileRepoImpl().updateData(
      mainId: mainId,
      collection: kMatchesCollection,
      data: data,
    );
    res.fold(
      (failure) {
        emit(WithdrawFailure(errMessage: failure.message));
      },
      (register) {
        emit(WithdrawSuccess());
      },
    );
  }

  void updateUser({
    required String mainId,
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    emit(UpdateUserLoading());
    var res = await ProfileRepoImpl().updateData(
      mainId: mainId,
      collection: collection,
      data: data,
    );
    res.fold(
      (failure) {
        emit(UpdateUserFailure(errMessage: failure.message));
      },
      (register) {
        emit(UpdateUserSuccess());
      },
    );
  }

  updatePlayers({
    required String mainId,
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    emit(UpdatePlayerLoading());
    var res = await ProfileRepoImpl().updateData(
      mainId: mainId,
      collection: collection,
      data: data,
    );
    res.fold(
      (failure) {
        emit(UpdatePlayerFailure(errMessage: failure.message));
      },
      (register) {
        emit(UpdatePlayerSuccess());
      },
    );
  }
}
