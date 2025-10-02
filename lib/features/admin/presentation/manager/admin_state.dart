part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AddMatchSuccess extends AdminState {}

class AddMatchError extends AdminState {
  final String failure;
  AddMatchError(this.failure);
}

class AddMatchLoading extends AdminState {}

class GetNewestMatchSuccess extends AdminState {
  final MatchModel matchModel;
  GetNewestMatchSuccess(this.matchModel);
}

class GetNewestMatchError extends AdminState {
  final String failure;
  GetNewestMatchError(this.failure);
}

class GetNewestMatchLoading extends AdminState {}

class GetNewestMatchEmpty extends AdminState {}
