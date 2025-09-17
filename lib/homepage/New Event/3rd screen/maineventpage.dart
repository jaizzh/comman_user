import 'package:common_user/homepage/New%20Event/1st%20screen/eventplan.dart';
import 'package:common_user/homepage/New%20Event/3rd%20screen/eventbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MinimalDemoPage extends StatefulWidget {
  const MinimalDemoPage({super.key});

  @override
  State<MinimalDemoPage> createState() => _MinimalDemoPageState();
}

class _MinimalDemoPageState extends State<MinimalDemoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Minimal Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: _buildCleanHeader(context),
                ),

                const SizedBox(height: 4),

                // Financial Overview
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: _buildFinancialSection(),
                ),

                const SizedBox(height: 10),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: _buildActionSection(),
                ),

                const SizedBox(height: 14),

                // Stats Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: _buildStatsSection(),
                ),

                const SizedBox(height: 24),
                PremiumEventCard(),
                SizedBox(
                  height: 20.0,
                ),
                PremiumEventCard(), // Extra bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCleanHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: const Color(0xFF374151),
            onPressed: () => Navigator.maybePop(context),
          ),

          // User Info
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Jega Vini",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  Text(
                    "Premium Member",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1,
                  ),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/jega.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Investment",
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "\$14,386",
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
                height: 1.0,
              ),
            ),
            Text(
              ".00",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF9A2143),
                border: Border.all(
                  color: const Color(0xFF9A2143),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "+12.5%",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionSection() {
    return Row(
      children: [
        Expanded(
          child: _buildCleanActionButton(
            "Create New Event",
            Icons.add,
            () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => eventplan()));
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCleanActionButton(
            "View History",
            Icons.history,
            () {},
          ),
        ),
      ],
    );
  }

  Widget _buildCleanActionButton(
      String label, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Color(0xFF9A2143), size: 20),
              const SizedBox(width: 4),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9A2143),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event Overview",
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: _buildMinimalStatCard(
                "7",
                "Total No.of Events",
                Icons.check_circle_outline,
                const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMinimalStatCard(
                "1",
                "No.Of Active Events",
                Icons.play_circle_outline,
                const Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMinimalStatCard(
                "6",
                "No.of Events Completed",
                Icons.schedule_outlined,
                const Color(0xFFF59E0B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMinimalStatCard(
      String value, String label, IconData icon, Color accentColor) {
    return Container(
      height: 100, // Fixed height instead of MediaQuery percentage
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: accentColor,
                size: 22,
              ),
              const SizedBox(width: 8.0),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}
