class ApiResponse {
  final bool success;
  final List<ProductModel> data;
  final Meta meta;

  ApiResponse({
    required this.success,
    required this.data,
    required this.meta,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      data: List<ProductModel>.from(
          json['data'].map((x) => ProductModel.fromJson(x))),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((x) => x.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class ProductModel {
  final int id;
  final int? externalId;
  final int productCategoryId;
  final Name name;
  final String type;
  final int purchasePrice;
  final int salePrice;
  final Name description;
  final bool? visible;
  final bool? available;
  final dynamic metadata;
  final dynamic min;
  final dynamic max;
  final bool numberly;
  final String source;
  final int averageRating;
  final List<Image> images;
  final String createdAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    this.externalId,
    required this.productCategoryId,
    required this.name,
    required this.type,
    required this.purchasePrice,
    required this.salePrice,
    required this.description,
    this.visible,
    this.available,
    this.metadata,
    this.min,
    this.max,
    required this.numberly,
    required this.source,
    required this.averageRating,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      externalId: json['external_id'],
      productCategoryId: json['product_category_id'],
      name: Name.fromJson(json['name']),
      type: json['type'],
      purchasePrice: json['purchase_price'],
      salePrice: json['old_price'],
      description: Name.fromJson(json['description']),
      visible: json['visible'],
      available: json['available'],
      metadata: json['metadata'],
      min: json['min'],
      max: json['max'],
      numberly: json['numberly'],
      source: json['source'],
      averageRating: json['average_rating'],
      images: List<Image>.from(json['images'].map((x) => Image.fromJson(x))),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'external_id': externalId,
      'product_category_id': productCategoryId,
      'name': name.toJson(),
      'type': type,
      'purchase_price': purchasePrice,
      'old_price': salePrice,
      'description': description.toJson(),
      'visible': visible,
      'available': available,
      'metadata': metadata,
      'min': min,
      'max': max,
      'numberly': numberly,
      'source': source,
      'average_rating': averageRating,
      'images': images.map((x) => x.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Image {
  final int id;
  final String path;
  final int imageableId;
  final String imageableType;
  final String createdAt;
  final String updatedAt;

  Image({
    required this.id,
    required this.path,
    required this.imageableId,
    required this.imageableType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      path: json['path'],
      imageableId: json['imageable_id'],
      imageableType: json['imageable_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'imageable_id': imageableId,
      'imageable_type': imageableType,
      'created_at': createdAt,
      'updated_at': updatedAt,
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
