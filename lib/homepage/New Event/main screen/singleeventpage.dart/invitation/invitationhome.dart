import 'dart:ui';

import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New Event/main screen/singleeventpage.dart/singleeventdashboard.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/Einvitation/e-invitation.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/videoinvitation/videoinvitation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvitationHome extends StatefulWidget {
  const InvitationHome({super.key});

  @override
  State<InvitationHome> createState() => _InvitationHomeState();
}

class _InvitationHomeState extends State<InvitationHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        toolbarHeight: size.height * 0.06,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black87, size: 22),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const singleventdashboard()),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.inventory_outlined,
                color: Colors.black87, size: 24),
          ),
          const SizedBox(width: 6),
        ],
      ),
      backgroundColor: Colors.grey.shade50,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 34),
          children: [
            Text(
              "Invitation Page",
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 18),

            // CARDS
            PremiumInvitationCard(
              heading: 'Physical Invitation',
              subheading:
                  'Make your physical invitation with vendors or upload the physical invitation',
              imageAsset: 'assets/images/invit3.jpg',
              onTap: () {},
              fade: _fadeAnimation,
              scale: _scaleAnimation,
              goldDark: AppColors.darkGold,
              goldLight: AppColors.lightGold,
              primary: AppColors.primary,
            ),
            const SizedBox(height: 20),
            PremiumInvitationCard(
              heading: 'E-invitation',
              subheading:
                  'Make your E-invitation and share through your mobile apps',
              imageAsset: 'assets/images/invit2.jpg',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Einvitation()));
              },
              fade: _fadeAnimation,
              scale: _scaleAnimation,
              goldDark: AppColors.darkGold,
              goldLight: AppColors.lightGold,
              primary: AppColors.primary,
            ),
            const SizedBox(height: 20),
            PremiumInvitationCard(
              heading: 'Video Invitation',
              subheading: 'Create your video invitation with event details',
              imageAsset: 'assets/images/invit4.jpg',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => videoinvitation()));
              },
              fade: _fadeAnimation,
              scale: _scaleAnimation,
              goldDark: AppColors.darkGold,
              goldLight: AppColors.lightGold,
              primary: AppColors.primary,
            ),
            const SizedBox(height: 20),
            PremiumInvitationCard(
              heading: 'Create Sub-domain',
              subheading:
                  'Sub-domains are websites that hold information about your event',
              imageAsset: 'assets/images/inviti.jpg',
              onTap: () {},
              fade: _fadeAnimation,
              scale: _scaleAnimation,
              goldDark: AppColors.darkGold,
              goldLight: AppColors.lightGold,
              primary: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Premium, compact, responsive card
class PremiumInvitationCard extends StatelessWidget {
  const PremiumInvitationCard({
    super.key,
    required this.heading,
    required this.subheading,
    required this.imageAsset,
    required this.onTap,
    required this.fade,
    required this.scale,
    required this.goldDark,
    required this.goldLight,
    required this.primary,
  });

  final String heading;
  final String subheading;
  final String imageAsset;
  final VoidCallback onTap;
  final Animation<double> fade;
  final Animation<double> scale;

  final Color goldDark;
  final Color goldLight;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // responsive sizes (compact)
    final double cardHeight =
        (w * 0.26).clamp(112.0, 138.0); // smaller than before
    final double cardWidth = (w * 0.88).clamp(320.0, 520.0);
    final double imageSize = (cardHeight * 0.58).clamp(60.0, 92.0);
    final double textMaxWidth = (cardWidth - imageSize) * 0.68;

    return SizedBox(
      height: cardHeight + 8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // main card
          Align(
            alignment: Alignment.center,
            child: Container(
              height: cardHeight,
              width: cardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFFF3D2),
                    goldLight.withOpacity(0.95),
                    const Color(0xFFE3C98A),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    spreadRadius: 1,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(1.8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // frosted inner
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.9),
                            goldLight.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: InkWell(
                        onTap: onTap,
                        splashColor: primary.withOpacity(0.08),
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: imageSize / 2 + 20,
                            top: 14,
                            bottom: 14,
                          ),
                          child: Row(
                            children: [
                              // text
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: textMaxWidth),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      heading,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18, // slightly smaller
                                        letterSpacing: 0.2,
                                        color: primary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      subheading,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.5,
                                        height: 1.35,
                                        color: Colors.grey.shade900,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 2,
                                      width: 58,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        gradient: LinearGradient(
                                          colors: [
                                            goldDark.withOpacity(0.9),
                                            goldLight.withOpacity(0.65),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // floating circular image with subtle gold ring
          Positioned(
            right: 20,
            top: (cardHeight - imageSize) / 2,
            child: ScaleTransition(
              scale: scale,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [goldDark, goldLight.withOpacity(0.95)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: goldDark.withOpacity(0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    height: imageSize,
                    width: imageSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(imageAsset)),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover, // cleaner crop
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
