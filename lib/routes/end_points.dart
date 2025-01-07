import 'package:flutter/foundation.dart';

@immutable
final class EndPoints {
  const EndPoints();

  static const Auth auth = Auth();
  static const User user = User();
  static const General general = General();
  static const Store store = Store();

  static const String baseApi = 'https://backend.promotion22.com/api';
  // static const String baseApi = 'http://10.0.2.2:8000/api';
}

@immutable
final class Auth {
  const Auth();

  final String login = '${EndPoints.baseApi}/auth/login';
  final String register = '${EndPoints.baseApi}/auth/register';
  final String verifyCode = '${EndPoints.baseApi}/auth/verify-code';
  final String forgetPassword = '${EndPoints.baseApi}/auth/forget-password';
  final String resetPassword = '${EndPoints.baseApi}/auth/reset-password';
  final String logout = '${EndPoints.baseApi}/auth/logout';
}

@immutable
final class User {
  const User();
  final String myData = '${EndPoints.baseApi}/clients/me';
}

@immutable
final class General {
  const General();
  final String productsData = '${EndPoints.baseApi}/store/products';
}

@immutable
final class Store {
  const Store();

  final String productCategory =
      '${EndPoints.baseApi}/store/product-categories/{id}';
}
