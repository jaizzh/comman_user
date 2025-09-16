import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumInvitationCard extends StatelessWidget {
  const PremiumInvitationCard({
    Key? key,
    required this.heading,
    required this.subheading,
    required this.imageAsset,
    required this.onTap,
    required this.fade,
    required this.scale,
    required this.goldDark,
    required this.goldLight,
    required this.primary,
  }) : super(key: key);

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

    final double cardHeight = (w * 0.26).clamp(112.0, 160.0);
    final double cardWidth = (w * 0.88).clamp(320.0, 720.0);
    final double imageSize = (cardHeight * 0.58).clamp(60.0, 120.0);
    final double textMaxWidth = (cardWidth - imageSize) * 0.68;

    return SizedBox(
      height: cardHeight + 8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
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
                                        fontSize: 18,
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
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(imageAsset, fit: BoxFit.cover),
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
