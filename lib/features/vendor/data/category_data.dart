import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/data/makeupArtists_list.dart';
import 'package:common_user/features/vendor/data/music_list.dart';
import 'package:common_user/features/vendor/data/photo_list.dart';
import 'package:common_user/features/vendor/model/category_model.dart';
import 'package:flutter/material.dart';

List<CategoryModel> category = [
  CategoryModel(
      id: 1,
      name: "Photography",
      image: "assets/photo/photo1.png",
      vendorData: photoList,
      vendorType: "photo",
      color: AppColors.lightGold.withOpacity(0.7)),
  CategoryModel(
    id: 1,
    name: "Makeup Artist",
    image: "assets/makeup/makeup1.jpg",
    vendorData: makeupArtists,
    vendorType: "makeup",
    color: Colors.cyanAccent.withOpacity(0.5),
  ),
  CategoryModel(
      id: 1,
      name: "DJ & Music",
      image: "assets/music/music1.jpg",
      vendorData: musicDanceList,
      vendorType: "music",
      color: Colors.blue.withOpacity(0.5)),
  CategoryModel(
      id: 1,
      name: "Decoration",
      image: "assets/photo/deco.jpg",
      vendorData: photoList,
      vendorType: "photo",
      color: Colors.pink.withOpacity(0.5)),
  CategoryModel(
    id: 1,
    name: "Mehendi Artist",
    image: "assets/photo/meha.jpg",
    vendorData: makeupArtists,
    vendorType: "makeup",
    color: Colors.greenAccent.withOpacity(0.5),
  ),
  CategoryModel(
      id: 1,
      name: "Lighting & Sound",
      image: "assets/photo/light.avif",
      vendorData: musicDanceList,
      vendorType: "music",
      color: AppColors.lightGold.withOpacity(0.7)),
  CategoryModel(
      id: 1,
      name: "Invitation Cards",
      image: "assets/photo/invite.jpg",
      vendorData: photoList,
      vendorType: "photo",
      color: Colors.blue.withOpacity(0.5)),
  CategoryModel(
    id: 1,
    name: "Bridal Wear",
    image: "assets/photo/wear.jpg",
    vendorData: makeupArtists,
    vendorType: "makeup",
    color: Colors.tealAccent.withOpacity(0.5),
  ),
  CategoryModel(
      id: 1,
      name: "Flower Shop",
      image: "assets/photo/flower.jpg",
      vendorData: musicDanceList,
      vendorType: "music",
      color: Colors.pink.withOpacity(0.5)),
];
