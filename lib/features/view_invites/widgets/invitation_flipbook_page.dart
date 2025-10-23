import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvitationViewPage extends StatefulWidget {
  const InvitationViewPage({super.key});

  @override
  State<InvitationViewPage> createState() => _InvitationViewPageState();
}

class _InvitationViewPageState extends State<InvitationViewPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    "assets/images/invit2.jpg",
    "assets/images/invite1.png",
    "assets/images/invit2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: screenHeight,
                ),
              );
            },
          ),
          // Back Arrow positioned at top-left
          Positioned(
            top: 40,
            left: 15,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Card(
                color: AppColors.black,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          // Slide text hint
          Positioned(
            bottom: 60,
            child: Text(
              _currentPage < images.length - 1
                  ? "← Slide left to view more"
                  : "You’ve reached the last image",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          // Page indicator dots
          Positioned(
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 10 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? AppColors.primary : Colors.grey,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
