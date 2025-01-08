import 'package:flutter/material.dart';

class HandlingDataView {
  final bool loading;
  final bool dataIsEmpty;
  final bool isValid;
  final Widget? response;

  HandlingDataView({
    required this.loading,
    required this.dataIsEmpty,
  })  : isValid = (loading && dataIsEmpty) || dataIsEmpty,
        response = (loading && dataIsEmpty) || dataIsEmpty ? _buildResponse(loading, dataIsEmpty) : null;

  static Widget _buildResponse(bool loading, bool dataIsEmpty) {
    if (loading && dataIsEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (dataIsEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text(
            "No Data Found",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return const Scaffold();
  }
}
