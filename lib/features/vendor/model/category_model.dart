import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;
  final String vendorType;
  final List<dynamic> vendorData;
  final Color color;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.vendorType,
      required this.vendorData,
      required this.color});
}
