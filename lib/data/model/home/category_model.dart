class CategoryModel {
  final int id;
  final Name description;
  final Name name;
  final String? image;
  final bool? visible;
  final bool? available;
  final String? productDisplayMethod;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    this.visible,
    this.available,
    this.productDisplayMethod,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: Name.fromJson(json['name']),
      description: Name.fromJson(json['description']),
      image: json['image'],
      visible: json['visible'],
      available: json['available'],
      productDisplayMethod: json['product_display_method'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'description': description.toJson(),
      'image': image,
      'visible': visible,
      'available': available,
      'product_display_method': productDisplayMethod,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Name {
  final String? en;
  final String? ar;

  Name({this.en, this.ar});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      en: json['en'],
      ar: json['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}
