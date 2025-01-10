class Product {
  final String name;
  final String category;
  final int quantity;
  final double price;

  Product(
      {required this.name,
      required this.category,
      required this.quantity,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      category: json['category'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }
}

class Operator {
  final String name;
  final double amount;
  final String currency;
  final double cost;
  final int count;
  final double? rate;

  Operator({
    required this.name,
    required this.amount,
    required this.currency,
    required this.cost,
    required this.count,
    this.rate,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      name: json['name'],
      amount: json['price']['amount'].toDouble(),
      currency: json['price']['currency'],
      cost: json['cost'].toDouble(),
      count: json['count'],
      rate: json['rate']?.toDouble(),
    );
  }
}

class Country {
  final String name;
  final List<Operator> operators;

  Country({required this.name, required this.operators});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['country'],
      operators: (json['operators'] as List)
          .map((op) => Operator.fromJson(op))
          .toList(),
    );
  }
}
