import 'package:golden_eyes/models/tag_model.dart';

class CustomerModel {
  final int id;
  final String first_name;
  final String last_name;
  final String? camp;
  final List<TagModel> tags;
  final DateTime? created_at;
  final DateTime? deleted_at;

  CustomerModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    this.camp,
    required this.tags,
    this.created_at,
    this.deleted_at,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      camp: json['camp'],
      tags:
          json['tags'].map<TagModel>((tag) => TagModel.fromJson(tag)).toList(),
      created_at: DateTime.parse(json['created_at']),
      deleted_at: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
}
