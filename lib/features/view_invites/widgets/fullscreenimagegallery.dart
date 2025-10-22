import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// Call this page when the user taps on an image
class FullScreenImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;
  const FullScreenImageGallery({
    required this.imageUrls,
    required this.initialIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(imageUrls[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.5,
              );
            },
            pageController: PageController(initialPage: initialIndex),
            onPageChanged: (index) {},
          ),
          Positioned(
            top: 36,
            right: 12,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
