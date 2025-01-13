class OperatorModel {
  final String name;
  final Price price;
  final double cost;
  final int count;
  final double? rate;

  OperatorModel({
    required this.name,
    required this.price,
    required this.cost,
    required this.count,
    this.rate,
  });

  factory OperatorModel.fromJson(Map<String, dynamic> json) {
    return OperatorModel(
      name: json['name'],
      price: Price.fromJson(json['price']),
      cost: json['cost'].toDouble(),
      count: json['count'],
      rate: json['rate']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price.toJson(),
      'cost': cost,
      'count': count,
      'rate': rate,
    };
  }
}

class Price {
  final double amount;
  final String currency;

  Price({
    required this.amount,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}
