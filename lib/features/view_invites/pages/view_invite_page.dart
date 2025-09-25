// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';

// Assuming AppColors is defined in another file

class ViewInvitePage extends StatefulWidget {
  const ViewInvitePage({super.key});

  @override
  State<ViewInvitePage> createState() => _ViewInvitePageState();
}

class _ViewInvitePageState extends State<ViewInvitePage> {
  late ScrollController _scrollController;
  late String _currentImage;
  final List<String> _images = [
    "assets/images/invit2.jpg",
    "assets/images/invit3.jpg", // Add your other image paths here
    "assets/images/invit4.jpg",
    "assets/images/inviter.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _currentImage = _images.first; // Set the initial image
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Calculate the opacity of the title based on the scroll offset
  double get _titleOpacity {
    const double expandedHeight = 240.0;
    const double collapsedHeight = kToolbarHeight;
    final double scrollOffset =
        _scrollController.hasClients ? _scrollController.offset : 0;
    final double threshold = expandedHeight -
        collapsedHeight -
        40; // Adjust this value for desired effect

    if (scrollOffset > threshold) {
      final double opacity = (scrollOffset - threshold) /
          (expandedHeight - collapsedHeight - threshold);
      return opacity.clamp(0.0, 1.0);
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedBuilder(
                animation: _scrollController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _titleOpacity,
                    child: const Text("PhonePe Style Header"),
                  );
                },
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _currentImage,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentImage = _images[index];
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  _images[index],
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                height: 100,
                color: Colors.purple,
                alignment: Alignment.center,
                child: const Text(
                  "Widget 1",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 100,
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text(
                  "Widget 2",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 100,
                color: Colors.orange,
                alignment: Alignment.center,
                child: const Text(
                  "Widget 3",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Add as many widgets as you want
              const SizedBox(height: 400), // just for scroll space
            ],
          ),
        ),
      ),
    );
  }
}
