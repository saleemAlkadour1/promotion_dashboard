class ApiResponse {
  final bool success;
  final List<ProductStoreModel> data;
  final Meta meta;

  ApiResponse({
    required this.success,
    required this.data,
    required this.meta,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => ProductStoreModel.fromJson(item))
          .toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((item) => item.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class ProductStoreModel {
  final int id;
  final bool visible;
  final List<ValueItem> values;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductStoreModel({
    required this.id,
    required this.visible,
    required this.values,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductStoreModel.fromJson(Map<String, dynamic> json) {
    return ProductStoreModel(
      id: json['id'],
      visible: json['visible'],
      values: (json['values'] as List)
          .map((item) => ValueItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visible': visible,
      'values': values.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ValueItem {
  final int id;
  final int productItemsId;
  final String label;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ValueItem({
    required this.id,
    required this.productItemsId,
    required this.label,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ValueItem.fromJson(Map<String, dynamic> json) {
    return ValueItem(
      id: json['id'],
      productItemsId: json['product_items_id'],
      label: json['label'],
      value: json['value'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_items_id': productItemsId,
      'label': label,
      'value': value,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
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
