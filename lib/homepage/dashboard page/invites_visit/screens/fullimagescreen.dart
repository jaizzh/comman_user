import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

ImageProvider _imgAny(Object item) {
  if (item is String) {
    return item.startsWith('assets/')
        ? AssetImage(item)
        : FileImage(File(item));
  }
  if (item is XFile) {
    return FileImage(File(item.path));
  }
  throw ArgumentError('Unsupported type: ${item.runtimeType}');
}

void openImageBookMixed(BuildContext ctx, List<Object> items, {int start = 0}) {
  if (items.isEmpty) return;
  showDialog(
    context: ctx,
    barrierColor: Colors.black,
    builder: (_) => Stack(
      children: [
        PhotoViewGallery.builder(
          pageController:
              PageController(initialPage: start.clamp(0, items.length - 1)),
          itemCount: items.length,
          builder: (_, i) => PhotoViewGalleryPageOptions(
            imageProvider: _imgAny(items[i]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 4,
          ),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
        Positioned(
          top: 12 + MediaQuery.of(ctx).padding.top,
          right: 12,
          child: IconButton(
            onPressed: () => Navigator.pop(ctx),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
