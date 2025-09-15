import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/3rd%20screen/maineventpage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/planningtoolspage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/fisrthalfpage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/invitationhome.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/majorcont.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class singleventdashboard extends StatefulWidget {
  const singleventdashboard({super.key});

  @override
  State<singleventdashboard> createState() => _singleventdashboardState();
}

class _singleventdashboardState extends State<singleventdashboard> {
  bool planexpand = false;

  // Added scroll controller and title visibility tracking
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  final double _expandedHeight = 120.0;

  @override
  void initState() {
    super.initState();
    // Listen to scroll changes to hide/show title
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        bool isCollapsed =
            _scrollController.offset > (_expandedHeight - kToolbarHeight);
        if (isCollapsed != _showTitle) {
          setState(() {
            _showTitle = isCollapsed;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        controller: _scrollController, // Added scroll controller
        slivers: [
          // Premium App Bar
          _buildPremiumAppBar(),

          // Main Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                singledashhalf(),
                SizedBox(
                  height: 10.0,
                ),
                majorcont(),

                _buildQuickActions(),
                _buildFeatureCategories(),

                // Event Tools Grid
                _buildEventToolsGrid(),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumAppBar() {
    return SliverAppBar(
      expandedHeight: _expandedHeight,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      // Show title only when scrolled (collapsed)
      title: _showTitle
          ? Text(
              'Event Dashboard',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            )
          : null,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(1.0),
              AppColors.primary,
              AppColors.primary,
            ],
          ),
        ),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          // Show title only when expanded (not scrolled)
          title: !_showTitle
              ? Text(
                  'Event Dashboard',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              : null,
          centerTitle: false,
          titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => MinimalDemoPage())),
          ),
        ),
      ),
      actions: [
        _buildAppBarAction(Icons.notifications_on_rounded, () {}),
        _buildAppBarAction(Icons.more_vert_rounded, () {}),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildAppBarAction(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 20),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Planning Tools',
                  Icons.construction_rounded,
                  const Color(0xFF3B82F6),
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => planningtools())),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  'Invite Guests',
                  Icons.mail_outline_rounded,
                  const Color(0xFF10B981),
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => InvitationHome())),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCategories() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Features',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8), // Reduced spacing
          _buildFeatureGrid(),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    final features = [
      FeatureItem('Gift Registry', Icons.card_giftcard_rounded, 0.2, '1/5',
          const Color(0xFFF59E0B)),
      FeatureItem('Invitations', Icons.mail_rounded, 0.4, '2/4',
          const Color(0xFF3B82F6)),
      FeatureItem('Video Invite', Icons.videocam_rounded, 0.1, '1/10',
          const Color(0xFF10B981)),
      FeatureItem('Money Gifts', Icons.monetization_on_rounded, 0.54, '4/6',
          const Color(0xFF8B5CF6)),
      FeatureItem('Co-Hosts', Icons.group_rounded, 0.65, '2/3',
          const Color(0xFFEF4444)),
      FeatureItem('Live Stream', Icons.live_tv_rounded, 0.8, 'Ready',
          const Color(0xFF06B6D4)),
    ];

    return GridView.builder(
      padding: EdgeInsets.zero, // ✅ This fixes the gap issue
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return _buildFeatureCard(feature);
      },
    );
  }

  Widget _buildFeatureCard(FeatureItem feature) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: feature.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(feature.icon, color: feature.color, size: 20),
              ),
              const Spacer(),
              Text(
                feature.status,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: feature.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            feature.title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: feature.progress,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation(feature.color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventToolsGrid() {
    final tools = [
      ToolItem('Money/Task Report', Icons.live_tv_rounded,
          const Color(0xFFEF4444), () {}),
      ToolItem('Chat To The Guest', Icons.photo_library_rounded,
          const Color(0xFF3B82F6), () {}),
      ToolItem('Manual Contact Entry', Icons.location_on_rounded,
          const Color(0xFF10B981), () {}),
    ];

    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Tools',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: tools
                .map((tool) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: tools.indexOf(tool) < tools.length - 1
                                ? 12
                                : 0),
                        child: _buildToolCard(tool),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(ToolItem tool) {
    return GestureDetector(
      onTap: tool.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tool.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: tool.color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: tool.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(tool.icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              tool.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem {
  final String title;
  final IconData icon;
  final double progress;
  final String status;
  final Color color;

  FeatureItem(this.title, this.icon, this.progress, this.status, this.color);
}

class ToolItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  ToolItem(this.title, this.icon, this.color, this.onTap);
}
