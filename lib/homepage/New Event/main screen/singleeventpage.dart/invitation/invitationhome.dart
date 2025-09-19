import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/Einvitation/e-invitation.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/videoinvitation/videoinvitation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:widget_zoom/widget_zoom.dart';

class InvitationHome extends StatefulWidget {
  const InvitationHome({super.key});

  @override
  State<InvitationHome> createState() => _InvitationHomeState();
}

class _InvitationHomeState extends State<InvitationHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        //  physics: const BouncingScrollPhysics(),
        slivers: [
          _buildPremiumSliverAppBar(size),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Statistics Overview
                    _buildPremiumStatisticsSection(screenWidth),
                    SizedBox(
                      height: 16.0,
                    ),
                    // Completed Invitations Section

                    // Create New Invitations Section
                    _buildCreateInvitationsSection(screenWidth),
                    SizedBox(
                      height: 20.0,
                    ),

                    if (completedInvitations.isNotEmpty)
                      _buildCompletedInvitationsSection(screenWidth),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumSliverAppBar(Size size) {
    return SliverAppBar(
      expandedHeight: 50,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFFFAFBFC),
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      // title: Text(
      //   "Invitations",
      //   style: GoogleFonts.inter(
      //     fontSize: 24,
      //     fontWeight: FontWeight.w800,
      //     color: Colors.black87,
      //     letterSpacing: -0.5,
      //   ),
      // ),
      // centerTitle: true,
    );
  }

  Widget _buildPremiumStatisticsSection(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        // margin: const EdgeInsets.fromLTRB(16, 0, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Invitations",
                  style: GoogleFonts.sahitya(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCompactPremiumStatCard(
                    title: "Total Invitations",
                    value: "${completedInvitations.length}",
                    icon: Icons.mail_rounded,
                    screenWidth: screenWidth,
                  ),
                ),
                const SizedBox(width: 7),
                Container(
                  height: 40.0,
                  width: 1.0,
                  color: Colors.black26,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: _buildCompactPremiumStatCard(
                    title: "Pending Tasks",
                    value: "1",
                    icon: Icons.schedule_rounded,
                    screenWidth: screenWidth,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactPremiumStatCard({
    required String title,
    required String value,
    required IconData icon,
    // required Color primaryColor,
    required double screenWidth,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon and Value Row

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Container
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                // Value
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    height: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedInvitationsSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Invitations",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.325,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: completedInvitations.length,
            itemBuilder: (context, index) {
              final invitation = completedInvitations[index];
              return Container(
                margin: EdgeInsets.only(
                  right: index < completedInvitations.length - 1 ? 6 : 0,
                ),
                child: _buildPremiumCompletedCard(invitation, index),
              );
            },
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildPremiumCompletedCard(CompletedInvitation invitation, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: MediaQuery.of(context).size.height * 0.130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(invitation.imagepath),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(invitation.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getStatusIcon(invitation.status),
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            invitation.status,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    invitation.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getTypeIcon(invitation.type),
                          size: 12,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _getTypeText(invitation.type),
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            showZoomDialog();
                          },
                          icon: const Icon(Icons.visibility_rounded, size: 16),
                          label: const Text(
                            "View",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(
                                color: AppColors.primary, width: 1.75),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share_rounded, size: 16),
                          label: const Text("Share"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showZoomDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: WidgetZoom(
            heroAnimationTag: 'dialog_image_tag',
            zoomWidget: Image.asset(
              'assets/images/wedcat4.jpg',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateInvitationsSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildPremiumNewInvitationCard(
                title: 'Physical Invitation',
                subtitle: 'Premium printed cards with elegant designs',
                icon: Icons.card_giftcard_rounded,
                gradient: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.8)
                ],
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildPremiumNewInvitationCard(
                title: 'E-invitation',
                subtitle: 'Digital invites to share instantly',
                icon: Icons.email_rounded,
                gradient: [Colors.blue.shade600, Colors.blue.shade400],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Einvitation()),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildPremiumNewInvitationCard(
                title: 'Video Invitation',
                subtitle: 'Personalized video messages',
                icon: Icons.videocam_rounded,
                gradient: [Colors.purple.shade600, Colors.purple.shade400],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const videoinvitation()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumNewInvitationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradient.first.withOpacity(0.1),
            gradient.last.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: gradient.first.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: gradient.first,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods for status and type
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green.shade600;
      case 'Sent':
        return Colors.blue.shade600;
      case 'In Progress':
        return Colors.orange.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle_rounded;
      case 'Sent':
        return Icons.send_rounded;
      case 'In Progress':
        return Icons.pending_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  IconData _getTypeIcon(InvitationType type) {
    switch (type) {
      case InvitationType.physical:
        return Icons.card_giftcard_rounded;
      case InvitationType.eInvitation:
        return Icons.email_rounded;
      case InvitationType.video:
        return Icons.videocam_rounded;
    }
  }

  String _getTypeText(InvitationType type) {
    switch (type) {
      case InvitationType.physical:
        return 'Physical';
      case InvitationType.eInvitation:
        return 'E-invite';
      case InvitationType.video:
        return 'Video';
    }
  }
}

// Data models remain the same
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
