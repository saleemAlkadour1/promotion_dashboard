import 'package:promotion_dashboard/data/model/home/products/products_type/live/servers/five_sim/operator_model.dart';

class CountryModel {
  final String countryName;
  final List<OperatorModel> operators;

  CountryModel({
    required this.countryName,
    required this.operators,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryName: json['country'],
      operators: (json['operators'] as List)
          .map((operator) => OperatorModel.fromJson(operator))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': countryName,
      'operators': operators.map((operator) => operator.toJson()).toList(),
    };
  }
}
