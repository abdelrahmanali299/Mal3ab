import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/features/admin/data/models/match_model.dart';
import 'package:mal3ab/features/admin/data/repos/admin_repo_impl.dart';
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  @override
  void onChange(Change<AdminState> change) {
    log(change.toString());
    super.onChange(change);
  }

  AdminCubit() : super(AdminInitial());

  addMatch({required MatchModel matchModel}) async {
    emit(AddMatchLoading());
    var res = await AdminRepoImpl().addMatch(
      matchModel: matchModel,
      mainId: matchModel.id ?? '',
      mainPath: kMatchesCollection,
    );
    res.fold(
      (l) => emit(AddMatchError(l.message)),
      (r) => emit(AddMatchSuccess()),
    );
  }

  MatchModel matchModel = MatchModel();
  getNewestMatch() async {
    emit(GetNewestMatchLoading());
    var res = await AdminRepoImpl().getNewestMatch(kMatchesCollection);

    res.fold(
      (l) {
        print('get newest match error ${l.message}');
        emit(GetNewestMatchError(l.message));
      },
      (r) {
        if (r == null) {
          emit(GetNewestMatchEmpty());
        } else {
          matchModel = r;
          emit(GetNewestMatchSuccess(r));
        }
      },
    );
  }
}
