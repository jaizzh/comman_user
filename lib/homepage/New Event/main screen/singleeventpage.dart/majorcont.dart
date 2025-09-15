import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/circleinvite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class majorcont extends StatefulWidget {
  const majorcont({super.key});

  @override
  State<majorcont> createState() => _majorcontState();
}

class _majorcontState extends State<majorcont> {
  // Color palette constants
  static const Color primaryBurgundy = Color(0xFF9A2143);
  static const Color secondaryYellow = Color(0xFFEDD498);
  static const Color primaryWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      // margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Invite & collaberate",
                style: GoogleFonts.inter(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              )
            ],
          ),
          SizedBox(height: 20.0),
          // Top Section - Collaboration Header (45% of space)
          Expanded(
            flex: 45,
            child: _buildCompactCollaborationHeader(),
          ),

          const SizedBox(height: 16),

          // Middle Section - Stats Row (27% of space)
          Expanded(
            flex: 33,
            child: _buildCompactStatsRow(),
          ),

          const SizedBox(height: 12),

          // Bottom Section - Action Buttons (25% of space)
          Expanded(
            flex: 22,
            child: _buildCompactActionButtons(),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCompactCollaborationHeader() {
    return Row(
      children: [
        // Left Side - Guest Invitation Circle
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                primaryBurgundy,
                primaryBurgundy.withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: primaryBurgundy.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: primaryWhite,
              shape: BoxShape.circle,
            ),
            child: AmountDial(),
          ),
        ),

        const SizedBox(width: 20),

        // Right Side - Collaboration Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header Row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryBurgundy,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: primaryBurgundy.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.groups_rounded,
                      color: primaryWhite,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Event Collaboration',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(
                            0xFF1E293B), // Dark gray for better readability
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Description
              Text(
                'Invite guests and collaborate with co-hosts to make your event successful',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B), // Medium gray
                  height: 1.4,
                  letterSpacing: -0.1,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 14),

              // Status Indicators
              Row(
                children: [
                  _buildStatusIndicator(
                      '0 Guests', Icons.people_outline_rounded),
                  const SizedBox(width: 10),
                  _buildStatusIndicator('0 Co-hosts', Icons.handshake_outlined),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: secondaryYellow.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryBurgundy.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: primaryBurgundy,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: primaryBurgundy,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatsRow() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: primaryWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMiniStatCard(
              'Invited',
              '0',
              Icons.mail_outline_rounded,
            ),
          ),
          _buildStatDivider(),
          Expanded(
            child: _buildMiniStatCard(
              'Confirmed',
              '3',
              Icons.check_circle_outline_rounded,
            ),
          ),
          _buildStatDivider(),
          Expanded(
            child: _buildMiniStatCard(
              'Pending',
              '0',
              Icons.schedule_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFE2E8F0).withOpacity(0.0),
            const Color(0xFFE2E8F0),
            const Color(0xFFE2E8F0).withOpacity(0.0),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStatCard(String title, String count, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryBurgundy.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: primaryBurgundy,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              count,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B), // Dark for numbers
                height: 1.0,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B), // Medium gray for labels
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildPrimaryActionButton(
            'Invite Guests',
            Icons.person_add_alt_1_rounded,
            () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSecondaryActionButton(
            'Add Co-Host',
            Icons.handshake_rounded,
            () {},
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryActionButton(
      String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBurgundy,
              primaryBurgundy.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: primaryBurgundy.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: primaryWhite,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryWhite,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryActionButton(
      String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: primaryBurgundy.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: secondaryYellow.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: primaryBurgundy,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryBurgundy,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
