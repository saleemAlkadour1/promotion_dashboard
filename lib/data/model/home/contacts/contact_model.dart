class ContactModel {
  final int id;
  final Name name;
  final String url;
  final String icon;
  final String color;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContactModel({
    required this.id,
    required this.name,
    required this.url,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: Name.fromJson(json['name']),
      url: json['url'],
      icon: json['icon'],
      color: json['color'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'url': url,
      'icon': icon,
      'color': color,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Name {
  final String en;
  final String ar;

  Name({
    required this.en,
    required this.ar,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      en: json['en'],
      ar: json['ar'] ?? 'No name',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}
