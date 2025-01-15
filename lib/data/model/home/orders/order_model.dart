class OrderModel {
  final int id;
  final int? externalId;
  final int count;
  final String description;
  final String purchasePrice;
  final String status;
  final String salePrice;
  final dynamic metadata;
  final String? executeAt;
  final String? completedAt;
  final String? canceledAt;
  final String createdAt;
  final String updatedAt;
  final Product product;
  final List<dynamic> productItems;
  final User user;

  OrderModel({
    required this.id,
    required this.externalId,
    required this.count,
    required this.description,
    required this.purchasePrice,
    required this.status,
    required this.salePrice,
    required this.metadata,
    this.executeAt,
    this.completedAt,
    this.canceledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.productItems,
    required this.user,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0, // Provide default value if missing
      externalId: json['external_id'] ?? 0, // Default to 0 if missing
      count: json['count'] ?? 0, // Default to 0 if missing
      description:
          json['description'] ?? '', // Default to empty string if missing
      purchasePrice: json['purchase_price'] ?? '', // Default to empty string
      status: json['status'] ?? '', // Default to empty string if missing
      salePrice: json['sale_price'] ?? '', // Default to empty string if missing
      metadata: json['metadata'] ?? {}, // Default to empty map if missing
      executeAt: json['execute_at'],
      completedAt: json['completed_at'],
      canceledAt: json['canceled_at'],
      createdAt: json['created_at'] ?? '', // Default to empty string if missing
      updatedAt: json['updated_at'] ?? '', // Default to empty string if missing
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : Product.empty(), // Handle null safely
      productItems: json['productItems'] ?? [], // Default to empty list
      user: User.fromJson(
          json['user'] ?? {}), // Default to empty map if user is missing
    );
  }
}

class Product {
  final int id;
  final String type;
  final String purchasePrice;
  final bool visible;
  final bool available;
  final dynamic metadata;
  final Category category;

  Product({
    required this.id,
    required this.type,
    required this.purchasePrice,
    required this.visible,
    required this.available,
    required this.metadata,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Handle missing data
      type: json['type'] ?? '', // Handle missing data
      purchasePrice: json['purchase_price']?.toString() ??
          '', // Handle missing or null data
      visible: json['visible'] ?? false, // Default to false if missing
      available: json['available'] ?? false, // Default to false if missing
      metadata: json['metadata'] ?? {}, // Default to empty map if missing
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : Category.empty(), // Handle null safely
    );
  }

  static Product empty() {
    return Product(
      id: 0,
      type: '',
      purchasePrice: '',
      visible: false,
      available: false,
      metadata: {},
      category: Category.empty(),
    );
  }
}

class Category {
  final int id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String image;
  final bool visible;

  Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.image,
    required this.visible,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0, // Handle missing data
      nameEn: json['name']['en'] ?? '', // Handle missing data
      nameAr: json['name']['ar'] ?? '', // Handle missing data
      descriptionEn: json['description']['en'] ?? '', // Handle missing data
      descriptionAr: json['description']['ar'] ?? '', // Handle missing data
      image: json['image'] ?? '', // Handle missing data
      visible: json['visible'] ?? false, // Default to false if missing
    );
  }

  static Category empty() {
    return Category(
      id: 0,
      nameEn: '',
      nameAr: '',
      descriptionEn: '',
      descriptionAr: '',
      image: '',
      visible: false,
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final num walletBalance;
  final String phone;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.walletBalance,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // Handle missing data
      firstName: json['first_name'] ?? '', // Handle missing data
      lastName: json['last_name'] ?? '', // Handle missing data
      email: json['email'] ?? '', // Handle missing data
      walletBalance: json['wallet_balance'] ?? 0, // Default to 0 if missing
      phone: json['phone'] ?? '', // Handle missing data
    );
  }
}
