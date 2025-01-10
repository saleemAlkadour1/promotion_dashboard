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

  // دالة لتحويل JSON إلى كائن من نوع Item
  factory FiveSimProductModel.fromJson(Map<String, dynamic> json) {
    return FiveSimProductModel(
      name: json['name'].toString(), // لتحويل الاسم إلى String إذا كان رقماً
      category: json['category'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  // دالة لتحويل كائن من نوع Item إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
    };
  }
}
