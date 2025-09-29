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

final class UpdateLoading extends ProfileState {}

final class UpdateFailure extends ProfileState {
  final String errMessage;

  UpdateFailure({required this.errMessage});
}

final class UpdatewSuccess extends ProfileState {}
