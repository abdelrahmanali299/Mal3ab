part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterSuccess extends RegisterState {
  final UserModel userModel;

  RegisterSuccess({required this.userModel});
}
final class RegisterFailure extends RegisterState {
  final String errMessage;

  RegisterFailure({required this.errMessage});
}
final class RegisterLooding extends RegisterState {}

