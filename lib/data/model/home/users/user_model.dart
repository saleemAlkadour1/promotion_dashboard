class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      walletBalance: (json['wallet_balance'] as num).toDouble(),
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'wallet_balance': walletBalance,
      'phone': phone,
      'description': description,
      'profile_photo': profilePhoto,
      'approve': approve,
      'verify_code': verifyCode,
      'role': role,
      'code_expiry_date': codeExpiryDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class MetaData {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  MetaData({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}
