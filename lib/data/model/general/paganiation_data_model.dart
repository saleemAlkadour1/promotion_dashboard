class PaganationDataModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  PaganationDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
  factory PaganationDataModel.fromJson(Map<String, dynamic> json) =>
      PaganationDataModel(
        currentPage: json['current_page'],
        lastPage: json['last_page'],
        perPage: json['per_page'] ?? 20,
        total: json['total'],
      );
}
