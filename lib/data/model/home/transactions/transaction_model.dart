class TransactionModel {
  final int id;
  final double amount;
  final String currency;
  final int categoryId;
  final String type;
  final int userId;
  final String description;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.categoryId,
    required this.type,
    required this.userId,
    required this.description,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: double.parse(json['amount']),
      currency: json['currency'],
      categoryId: json['category_id'],
      type: json['type'],
      userId: json['user_id'],
      description: json['description'],
      metadata: json['metadata'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final double walletBalance;
  final String phone;
  final String? description;
  final String? profilePhoto;
  final bool approve;
  final String verifyCode;
  final String role;
  final DateTime codeExpiryDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.walletBalance,
    required this.phone,
    this.description,
    this.profilePhoto,
    required this.approve,
    required this.verifyCode,
    required this.role,
    required this.codeExpiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      walletBalance: json['wallet_balance'].toDouble(),
      phone: json['phone'],
      description: json['description'],
      profilePhoto: json['profile_photo'],
      approve: json['approve'],
      verifyCode: json['verify_code'],
      role: json['role'],
      codeExpiryDate: DateTime.parse(json['code_expiry_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
