import 'package:common_user/features/vendor/pages/vendor_home.dart';
import 'package:common_user/features/venue/presentation/pages/venue_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class singledashhalf extends StatefulWidget {
  const singledashhalf({super.key});

  @override
  State<singledashhalf> createState() => _singledashhalfState();
}

class _singledashhalfState extends State<singledashhalf> {
  static const Color buttonColor = Color(0xFF9A2143); // Burgundy
  static const Color boxLightColor = Color(0xFFEDD498); // Light Yellow
  static const Color boxBoxLight = Color(0xFFF3ECE3); // Very Light Beige
  static const Color primaryWhite = Colors.white; // Major White
  static const Color textDark = Colors.black;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            firstcont(),
            _buildPremiumVenueVendorSection(),
          ],
        ),
      ),
    );
  }

  Widget firstcont() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: buttonColor.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.trending_up_rounded,
                                color: primaryWhite,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                "Events Completed",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: textDark,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: boxLightColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: buttonColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          "3/14",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: buttonColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: const LinearProgressIndicator(
                      backgroundColor: boxBoxLight,
                      value: 0.21, // 3/14 ≈ 21%
                      valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                      minHeight: 10.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: CompactPlanContainer(),
          ),
          // Event Header Section

          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }

  Widget _buildPremiumVenueVendorSection() {
    return Container(
      color: primaryWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: venuevendor(
                    imagePath: "assets/images/venueor.png",
                    total: '0/1',
                    title: 'Vendors',
                    isVendor: true,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: venuevendor(
                    imagePath: "assets/images/vendoror.png",
                    total: '1/3',
                    title: 'Venues',
                    isVendor: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget venuevendor({
    required String imagePath,
    required String total,
    required String title,
    required bool isVendor,
  }) {
    // Extract current and total numbers
    final parts = total.split('/');
    final current = int.parse(parts[0]);
    final totalCount = int.parse(parts[1]);
    final progress = totalCount > 0 ? current / totalCount : 0.0;

    return Card(
      elevation: 4.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(current, totalCount).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(current, totalCount)
                            .withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      total,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(current, totalCount),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Image and progress section
              Row(
                children: [
                  // Image container
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: buttonColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isVendor ? Icons.store : Icons.location_on,
                              color: buttonColor,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Progress and status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getStatusText(current, totalCount),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Progress bar
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getStatusColor(current, totalCount),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          '${(progress * 100).toInt()}% Complete',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isVendor)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => VendorHome()));
                    else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => VenueHome()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: current == totalCount
                        ? Colors.green[50]
                        : buttonColor.withOpacity(0.1),
                    foregroundColor:
                        current == totalCount ? Colors.green[700] : buttonColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: current == totalCount
                            ? Colors.green.withOpacity(0.3)
                            : buttonColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      current == totalCount
                          ? '✓ ${isVendor ? 'Vendors' : 'Venues'} Selected'
                          : '+ Add ${isVendor ? 'Vendors' : 'Venues'}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods
  Color _getStatusColor(int current, int total) {
    if (current == 0) {
      return Colors.red[400]!;
    } else if (current == total) {
      return Colors.green[500]!;
    } else {
      return Colors.orange[500]!;
    }
  }

  String _getStatusText(int current, int total) {
    if (current == 0) {
      return 'Not started';
    } else if (current == total) {
      return 'Completed';
    } else {
      return 'In progress';
    }
  }
}

class CompactPlanContainer extends StatelessWidget {
  final String price;
  final String trialText;
  final VoidCallback? onTap;

  const CompactPlanContainer({
    Key? key,
    this.price = 'Choose Your Plan',
    this.trialText = 'Upgrade plan to get more Feature',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Check Circle
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.money_off_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),

                const SizedBox(width: 12),

                // Text Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          price,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      trialText,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black45, width: 2)),
            )
          ],
        ),
      ),
    );
  }
}
