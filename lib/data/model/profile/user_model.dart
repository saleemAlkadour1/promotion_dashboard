import 'dart:convert';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int walletBalance;
  final String phone;
  final dynamic description;
  final dynamic profilePhoto;
  final bool approve;
  final String verifyCode;
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
    required this.description,
    required this.profilePhoto,
    required this.approve,
    required this.verifyCode,
    required this.codeExpiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        walletBalance: json["wallet_balance"],
        phone: json["phone"],
        description: json["description"] ?? '',
        profilePhoto: json["profile_photo"] ?? '',
        approve: json["approve"],
        verifyCode: json["verify_code"],
        codeExpiryDate: DateTime.parse(json["code_expiry_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "wallet_balance": walletBalance,
        "phone": phone,
        "description": description,
        "profile_photo": profilePhoto,
        "approve": approve,
        "verify_code": verifyCode,
        "code_expiry_date": codeExpiryDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
