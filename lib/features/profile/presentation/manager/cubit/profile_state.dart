part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class RegisterLoading extends ProfileState {}

final class RegisterFailure extends ProfileState {
  final String errMessage;

  RegisterFailure({required this.errMessage});
}

final class RegisterSuccess extends ProfileState {}

final class WithdrawLoading extends ProfileState {}

final class WithdrawFailure extends ProfileState {
  final String errMessage;

  WithdrawFailure({required this.errMessage});
}

final class WithdrawSuccess extends ProfileState {}

final class UpdateUserLoading extends ProfileState {}

final class UpdateUserFailure extends ProfileState {
  final String errMessage;

  UpdateUserFailure({required this.errMessage});
}

final class UpdateUserSuccess extends ProfileState {}

final class UpdatePlayerLoading extends ProfileState {}

final class UpdatePlayerFailure extends ProfileState {
  final String errMessage;

  UpdatePlayerFailure({required this.errMessage});
}

final class UpdatePlayerSuccess extends ProfileState {}
