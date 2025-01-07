class Image {
  final int id;
  final String path;
  final int imageableId;
  final String imageableType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Image({
    required this.id,
    required this.path,
    required this.imageableId,
    required this.imageableType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        path: json["path"],
        imageableId: json["imageable_id"],
        imageableType: json["imageable_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "imageable_id": imageableId,
        "imageable_type": imageableType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
