class ResponseModel {
  final bool success;
  final List<NotificationModel> notifications;
  final Meta meta;

  ResponseModel({
    required this.success,
    required this.notifications,
    required this.meta,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      notifications: (json['data'] as List)
          .map((item) => NotificationModel.fromJson(item))
          .toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class NotificationModel {
  final int id;
  final User user;
  final NotificationDetails details;
  final bool isRead;
  final String? readAt;
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    required this.id,
    required this.user,
    required this.details,
    required this.isRead,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      user: User.fromJson(json['user']),
      details: NotificationDetails.fromJson(json['notification']),
      isRead: json['is_read'],
      readAt: json['read_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String walletBalance;
  final String phone;
  final String? description;
  final String? profilePhoto;
  final int approve;
  final String verifyCode;
  final String? role;
  final String codeExpiryDate;
  final String createdAt;
  final String updatedAt;

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
    this.role,
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
      walletBalance: json['wallet_balance'],
      phone: json['phone'],
      description: json['description'],
      profilePhoto: json['profile_photo'],
      approve: json['approve'],
      verifyCode: json['verify_code'],
      role: json['role'],
      codeExpiryDate: json['code_expiry_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class NotificationDetails {
  final int id;
  final String type;
  final String title;
  final String message;
  final String? image;
  final String metadata;
  final String? creator;
  final String createdAt;

  NotificationDetails({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.image,
    required this.metadata,
    this.creator,
    required this.createdAt,
  });

  factory NotificationDetails.fromJson(Map<String, dynamic> json) {
    return NotificationDetails(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      image: json['image'],
      metadata: json['metadata'],
      creator: json['creator'],
      createdAt: json['created_at'],
    );
  }
}

class Meta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}
