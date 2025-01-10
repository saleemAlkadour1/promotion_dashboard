import 'package:flutter/foundation.dart';

@immutable
final class EndPoints {
  const EndPoints();

  static const Auth auth = Auth();
  static const User user = User();
  static const General general = General();
  static const Store store = Store();
  static const Server server = Server();

  static const String baseApi = 'https://backend.promotion22.com/api';
  // static const String baseApi = 'http://10.0.2.2:8000/api';
}

@immutable
final class Auth {
  const Auth();

  final String login = '${EndPoints.baseApi}/auth/login';
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
}

@immutable
final class Store {
  const Store();

  final String products = '${EndPoints.baseApi}/store/products';
  final String categories = '${EndPoints.baseApi}/store/product-categories';
  final String category = '${EndPoints.baseApi}/store/product-categories/{id}';
}

@immutable
final class Server {
  const Server();
  final String productsFiveSim =
      '${EndPoints.baseApi}/servers/five-sim/products';
}
