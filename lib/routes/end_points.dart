import 'package:flutter/foundation.dart';

@immutable
final class EndPoints {
  const EndPoints();

  static const Auth auth = Auth();
  static const User user = User();
  static const General general = General();
  static const Store store = Store();
  static const Order order = Order();
  static const Transaction transaction = Transaction();
  static const Notification notification = Notification();
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
  final String product = '${EndPoints.baseApi}/store/products/{id}';
  final String productItems = '${EndPoints.baseApi}/store/product-items';
  final String productItem = '${EndPoints.baseApi}/store/product-items/{id}';
  final String categories = '${EndPoints.baseApi}/store/product-categories';
  final String category = '${EndPoints.baseApi}/store/product-categories/{id}';
}

@immutable
final class Order {
  const Order();

  final String orders = '${EndPoints.baseApi}/store/orders';
  final String order = '${EndPoints.baseApi}/store/orders/{id}';
}

@immutable
final class Transaction {
  const Transaction();

  final String transactions = '${EndPoints.baseApi}/transactions';
  final String transaction = '${EndPoints.baseApi}/transactions/{id}';
}

@immutable
final class Notification {
  const Notification();

  final String notifications = '${EndPoints.baseApi}/users/notifications';
  final String notification = '${EndPoints.baseApi}/users/notifications/{id}';
  final String markAsRead =
      '${EndPoints.baseApi}/users/notifications/{id}/mark_read';
}

@immutable
final class Server {
  const Server();
  final String productsFiveSim =
      '${EndPoints.baseApi}/servers/five-sim/products';
  final String countriesAndOperators =
      '${EndPoints.baseApi}/servers/five-sim/countries-and-operators?product={product}';
}
