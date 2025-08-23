import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class Failure {
  final String message;
  Failure({required this.message});

  factory Failure.serverError(DioException ex) {
    final Map error = ex.response?.data;
    if (error.containsKey("message")) {
      return Failure(message: error["message"].toString());
    } else if (error.containsKey("errors")) {
      return Failure(message: error["errors"].toString());
    } else {
      switch (ex.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(message: "ConnectionTimeout".tr());
        case DioExceptionType.cancel:
          return Failure(message: "RequestCanceled".tr());
        case DioExceptionType.sendTimeout:
          return Failure(message: "SendTimeout".tr());
        case DioExceptionType.receiveTimeout:
          return Failure(message: "ReceiveTimeout".tr());
        case DioExceptionType.badResponse:
          return Failure(message: "BadResponse".tr());
        case DioExceptionType.connectionError:
          return Failure(message: "ConnectionError".tr());
        case DioExceptionType.unknown:
          return Failure(message: "ConnectionError".tr());
        default:
          return Failure(message: "DefaultErrorMessage".tr());
      }
    }
  }

  factory Failure.defaultMessage() {
    return Failure(message: "DefaultErrorMessage".tr());
  }
  factory Failure.errorMsg(String error) {
    return Failure(message: error);
  }
}
