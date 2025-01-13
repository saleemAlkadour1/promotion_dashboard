class FiveSimProductModel {
  final String name;
  final String category;
  final num quantity;
  final num price;

  FiveSimProductModel({
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
  });

  factory FiveSimProductModel.fromJson(Map<String, dynamic> json) {
    return FiveSimProductModel(
      name: json['name'].toString(),
      category: json['category'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
    };
  }
}
