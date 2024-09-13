class TagModel {
  final int id;
  final String name;
  final int customer_id;

  TagModel({
    required this.id,
    required this.name,
    required this.customer_id,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'],
      name: json['name'],
      customer_id: json['customer_id'],
    );
  }
}
