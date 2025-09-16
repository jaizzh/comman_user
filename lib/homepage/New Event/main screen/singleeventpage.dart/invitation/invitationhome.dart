import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/Einvitation/e-invitation.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/videoinvitation/videoinvitation.dart';
import 'package:common_user/homepage/summa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

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

  // Sample completed invitations data
  final List<CompletedInvitation> completedInvitations = [
    CompletedInvitation(
      id: '1',
      type: InvitationType.physical,
      title: 'Wedding Physical Cards',
      createdDate: DateTime.now().subtract(const Duration(days: 3)),
      status: 'Completed',
      recipients: 150,
      imagepath: 'assets/images/wedcat4.jpg',
    ),
    CompletedInvitation(
      id: '2',
      type: InvitationType.eInvitation,
      title: 'Birthday E-Invitation',
      createdDate: DateTime.now().subtract(const Duration(days: 7)),
      status: 'Sent',
      recipients: 45,
      imagepath: 'assets/images/wedcat3.jpg',
    ),
    CompletedInvitation(
      id: '3',
      type: InvitationType.video,
      title: 'Anniversary Video',
      createdDate: DateTime.now().subtract(const Duration(days: 1)),
      status: 'In Progress',
      recipients: 80,
      imagepath: 'assets/images/wedcat5.jpg',
    ),
  ];

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
    final screenWidth = size.width;

    return Scaffold(
      appBar: _buildPremiumAppBar(size),
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section

              // Statistics Overview
              _buildCompletedInvitationsSection(screenWidth),

              _buildStatisticsSection(screenWidth),

              // Create New Invitations Section
              _buildCreateInvitationsSection(screenWidth),

              // Completed Invitations Section

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildPremiumAppBar(Size size) {
    return AppBar(
      surfaceTintColor: Colors.white,
      toolbarHeight: size.height * 0.07,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 18,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const singleventdashboard()),
          );
        },
      ),
      title: Text(
        "Invitations",
        style: GoogleFonts.inter(
          fontSize: size.width * 0.045,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: -0.2,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildStatisticsSection(double screenWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              title: "Total Invitations",
              value: "${completedInvitations.length}",
              icon: Icons.mail_rounded,
              color: AppColors.primary,
              screenWidth: screenWidth,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              title: "Total Recipients",
              value:
                  "${completedInvitations.fold(0, (sum, inv) => sum + inv.recipients)}",
              icon: Icons.people_rounded,
              color: AppColors.darkGold,
              screenWidth: screenWidth,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              title: "Sent",
              value:
                  "${completedInvitations.where((inv) => inv.status == 'Sent' || inv.status == 'Completed').length}",
              icon: Icons.send_rounded,
              color: Colors.green.shade600,
              screenWidth: screenWidth,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required double screenWidth,
  }) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: screenWidth * 0.04),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.03,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateInvitationsSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 16),
          child: Text(
            "Create New Invitation",
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              letterSpacing: -0.2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
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
              const SizedBox(height: 16),
              PremiumInvitationCard(
                heading: 'E-invitation',
                subheading:
                    'Make your E-invitation and share through your mobile apps',
                imageAsset: 'assets/images/invit2.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Einvitation()),
                  );
                },
                fade: _fadeAnimation,
                scale: _scaleAnimation,
                goldDark: AppColors.darkGold,
                goldLight: AppColors.lightGold,
                primary: AppColors.primary,
              ),
              const SizedBox(height: 16),
              PremiumInvitationCard(
                heading: 'Video Invitation',
                subheading: 'Create your video invitation with event details',
                imageAsset: 'assets/images/invit4.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const videoinvitation()),
                  );
                },
                fade: _fadeAnimation,
                scale: _scaleAnimation,
                goldDark: AppColors.darkGold,
                goldLight: AppColors.lightGold,
                primary: AppColors.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedInvitationsSection(double screenWidth) {
    if (completedInvitations.isEmpty) {
      return _buildEmptyState(screenWidth);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 32, 18, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Completed Invitations",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenWidth * 0.55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: completedInvitations.length,
            itemBuilder: (context, index) {
              final valuee = completedInvitations[index];
              return Container(
                  // margin: EdgeInsets.only(
                  //     right: index < completedInvitations.length - 1 ? 16 : 0),
                  child: _buildCompletedInvitationCard(
                      imagecomplete: valuee.imagepath));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedInvitationCard({required String imagecomplete}) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            //  Container(),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(imagecomplete))),
            )
          ],
        ),
      ),
    );
    // return Container(
    //   width: screenWidth * 0.72,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(20),
    //     border: Border.all(
    //       color: typeInfo['color'].withOpacity(0.1),
    //       width: 1.5,
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: typeInfo['color'].withOpacity(0.08),
    //         blurRadius: 16,
    //         offset: const Offset(0, 8),
    //       ),
    //     ],
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Header with status
    //       Container(
    //         padding: const EdgeInsets.all(16),
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //             colors: [
    //               typeInfo['color'].withOpacity(0.05),
    //               Colors.white.withOpacity(0.8),
    //             ],
    //           ),
    //           borderRadius: const BorderRadius.only(
    //             topLeft: Radius.circular(20),
    //             topRight: Radius.circular(20),
    //           ),
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                 color: typeInfo['color'].withOpacity(0.1),
    //                 borderRadius: BorderRadius.circular(12),
    //               ),
    //               child: Icon(
    //                 typeInfo['icon'],
    //                 color: typeInfo['color'],
    //                 size: screenWidth * 0.05,
    //               ),
    //             ),
    //             _buildStatusBadge(invitation.status, screenWidth),
    //           ],
    //         ),
    //       ),

    //       // Content
    //       Expanded(
    //         child: Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 invitation.title,
    //                 style: GoogleFonts.inter(
    //                   fontSize: screenWidth * 0.042,
    //                   fontWeight: FontWeight.w700,
    //                   color: Colors.black87,
    //                 ),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),

    //               const SizedBox(height: 8),

    //               Text(
    //                 typeInfo['label'],
    //                 style: GoogleFonts.inter(
    //                   fontSize: screenWidth * 0.032,
    //                   fontWeight: FontWeight.w500,
    //                   color: typeInfo['color'],
    //                 ),
    //               ),

    //               const Spacer(),

    //               // Recipients and date info
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.people_outline_rounded,
    //                     size: screenWidth * 0.04,
    //                     color: Colors.grey.shade600,
    //                   ),
    //                   const SizedBox(width: 4),
    //                   Text(
    //                     "${invitation.recipients} recipients",
    //                     style: GoogleFonts.inter(
    //                       fontSize: screenWidth * 0.03,
    //                       fontWeight: FontWeight.w500,
    //                       color: Colors.grey.shade600,
    //                     ),
    //                   ),
    //                 ],
    //               ),

    //               const SizedBox(height: 6),

    //               Text(
    //                 _formatDate(invitation.createdDate),
    //                 style: GoogleFonts.inter(
    //                   fontSize: screenWidth * 0.028,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.grey.shade500,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),

    //       // Action buttons
    //       Container(
    //         padding: const EdgeInsets.all(16),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: OutlinedButton(
    //                 onPressed: () {
    //                   // View invitation details
    //                 },
    //                 style: OutlinedButton.styleFrom(
    //                   side:
    //                       BorderSide(color: typeInfo['color'].withOpacity(0.3)),
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(12),
    //                   ),
    //                   padding: const EdgeInsets.symmetric(vertical: 12),
    //                 ),
    //                 child: Text(
    //                   "View",
    //                   style: GoogleFonts.inter(
    //                     fontSize: screenWidth * 0.032,
    //                     fontWeight: FontWeight.w600,
    //                     color: typeInfo['color'],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(width: 8),
    //             Expanded(
    //               child: ElevatedButton(
    //                 onPressed: () {
    //                   // Share invitation
    //                 },
    //                 style: ElevatedButton.styleFrom(
    //                   backgroundColor: typeInfo['color'],
    //                   elevation: 0,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(12),
    //                   ),
    //                   padding: const EdgeInsets.symmetric(vertical: 12),
    //                 ),
    //                 child: Text(
    //                   "Share",
    //                   style: GoogleFonts.inter(
    //                     fontSize: screenWidth * 0.032,
    //                     fontWeight: FontWeight.w600,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildStatusBadge(String status, double screenWidth) {
    Color statusColor;
    switch (status) {
      case 'Completed':
        statusColor = Colors.green.shade600;
        break;
      case 'Sent':
        statusColor = Colors.blue.shade600;
        break;
      case 'In Progress':
        statusColor = Colors.orange.shade600;
        break;
      default:
        statusColor = Colors.grey.shade600;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.025,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          fontSize: screenWidth * 0.028,
          fontWeight: FontWeight.w600,
          color: statusColor,
        ),
      ),
    );
  }

  Widget _buildEmptyState(double screenWidth) {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: EdgeInsets.all(screenWidth * 0.08),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lightGold.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              size: screenWidth * 0.12,
              color: AppColors.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "No Completed Invitations",
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Start creating invitations to see them here",
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getInvitationTypeInfo(InvitationType type) {
    switch (type) {
      case InvitationType.physical:
        return {
          'label': 'Physical Invitation',
          'icon': Icons.mail_rounded,
          'color': AppColors.primary,
        };
      case InvitationType.eInvitation:
        return {
          'label': 'E-Invitation',
          'icon': Icons.email_rounded,
          'color': Colors.blue.shade600,
        };
      case InvitationType.video:
        return {
          'label': 'Video Invitation',
          'icon': Icons.video_call_rounded,
          'color': Colors.purple.shade600,
        };
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else if (difference < 7) {
      return "$difference days ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
}

// Data models
enum InvitationType { physical, eInvitation, video }

class CompletedInvitation {
  final String id;
  final InvitationType type;
  final String title;
  final DateTime createdDate;
  final String status;
  final int recipients;
  final String imagepath;

  CompletedInvitation({
    required this.imagepath,
    required this.id,
    required this.type,
    required this.title,
    required this.createdDate,
    required this.status,
    required this.recipients,
  });
}

/// Premium, compact, responsive card (keeping your original design)
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
    final double cardHeight = (w * 0.26).clamp(112.0, 138.0);
    final double cardWidth = (w * 0.88).clamp(320.0, 520.0);
    final double imageSize = (cardHeight * 0.58).clamp(60.0, 92.0);
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
                      image: DecorationImage(image: AssetImage(imageAsset)),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
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
