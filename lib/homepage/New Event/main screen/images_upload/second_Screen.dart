import 'package:flutter/material.dart';

class ViewScreenImage extends StatefulWidget {
  const ViewScreenImage({super.key});

  @override
  State<ViewScreenImage> createState() => _ViewScreenImageState();
}

class _ViewScreenImageState extends State<ViewScreenImage> {
  // NOTE: mutable list (no 'const') so we can delete items.
  final List<String> pictures = [
    "assets/venue_images/v1.jpg",
    "assets/venue_images/v2.jpg",
    "assets/venue_images/v3.jpg",
    "assets/venue_images/v4.jpg",
    "assets/venue_images/v5.jpg",
  ];

  void _deleteAt(int index) {
    setState(() => pictures.removeAt(index));
  }

  void _openFullScreen(String path) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullScreenImage(path: path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: pictures.length,
        itemBuilder: (context, index) {
          final singleImage = pictures[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.250,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // image with rounded corners + hero for smooth fullscreen
                  Hero(
                    tag: singleImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        singleImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Row(
                      children: [
                        _CircleIconButton(
                          icon: Icons.visibility_rounded,
                          tooltip: 'View',
                          onTap: () => _openFullScreen(singleImage),
                        ),
                        const SizedBox(width: 8),
                        _CircleIconButton(
                          icon: Icons.delete_outline_rounded,
                          tooltip: 'Delete',
                          onTap: () => _deleteAt(index),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Small round button with translucent background
class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final btn = InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black38,            // translucent bg
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );

    return tooltip == null ? btn : Tooltip(message: tooltip!, child: btn);
  }
}

/// Fullscreen single-image viewer (tap the close icon or back to exit)
class _FullScreenImage extends StatelessWidget {
  const _FullScreenImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // zoom/pan support
          Center(
            child: Hero(
              tag: path,
              child: InteractiveViewer(
                maxScale: 4,
                minScale: 0.8,
                child: Image.asset(path, fit: BoxFit.contain),
              ),
            ),
          ),
          // top-right close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 8,
            child: _CircleIconButton(
              icon: Icons.close_rounded,
              tooltip: 'Close',
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
