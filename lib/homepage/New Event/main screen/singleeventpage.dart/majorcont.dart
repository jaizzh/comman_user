import 'package:common_user/common/mobile%20contacts/groupingcontact.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/circleinvite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class majorcont extends StatefulWidget {
  const majorcont({super.key});

  @override
  State<majorcont> createState() => _majorcontState();
}

class _majorcontState extends State<majorcont> {
  // Color palette constants (fall back to AppColors.primary if available)
  static const Color primaryBurgundy = Color(0xFF9A2143);
  static const Color secondaryYellow = Color(0xFFEDD498);
  static const Color primaryWhite = Colors.white;
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMedium = Color(0xFF64748B);
  double _scaleForWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return (w / 375.0).clamp(0.80, 1.6);
  }

  List<Contact> _allContacts = [];
  List<Contact> _selectedContacts = [];

  // Helper text style factory
  TextStyle _txt(
    BuildContext context, {
    double size = 14,
    FontWeight weight = FontWeight.w600,
    Color? color,
    String? fontFamily,
  }) {
    final s = _scaleForWidth(context);
    return GoogleFonts.getFont(
      fontFamily ?? 'Inter',
      fontSize: size * s,
      fontWeight: weight,
      color: color ?? textDark,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleForWidth(context);

    // Use LayoutBuilder to create a container that adapts to available width/height
    return LayoutBuilder(builder: (context, constraints) {
      final double containerHeight = (constraints.maxHeight.isFinite
              ? constraints.maxHeight
              : MediaQuery.of(context).size.height) *
          0.35 *
          (s < 1 ? 1.05 : 1.0);
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: containerHeight,
          padding:
              EdgeInsets.symmetric(horizontal: 16.0 * s, vertical: 12.0 * s),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: primaryWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 18 * s,
                //   offset: Offset(0, 6 * s),
                spreadRadius: 1 * s,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10 * s,
                offset: Offset(0, 10 * s),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 6.0 * s),
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Invite & collaborate",
                    style: GoogleFonts.inter(
                      fontSize: 17.0 * s,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0 * s),
              Container(
                height: 1.0,
                color: Colors.black38,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              SizedBox(height: 10.0 * s),
              _buildCompactCollaborationHeader(context, s),
              SizedBox(height: 20.0 * s),
              _buildCompactActionButtons(context, s),
              SizedBox(height: 20.0 * s),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCompactCollaborationHeader(BuildContext context, double s) {
    return Row(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                primaryBurgundy,
                primaryBurgundy.withOpacity(0.86),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: primaryWhite,
              shape: BoxShape.circle,
            ),
            child: AmountDial(), // keeps your existing inner widget
          ),
        ),

        SizedBox(width: 16.0 * s),

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
                    padding: EdgeInsets.all(10.0 * s),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0 * s),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 3,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.groups_rounded,
                      color: Colors.black,
                      size: 18.0 * s,
                    ),
                  ),
                  SizedBox(width: 12.0 * s),
                  Expanded(
                    child: Text(
                      'Event Collaboration',
                      style: GoogleFonts.inter(
                        fontSize: 16.0 * s,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.0 * s),

              // Description
              Text(
                'Invite guests and collaborate with co-hosts to make your event successful',
                style: GoogleFonts.inter(
                  fontSize: 12.0 * s,
                  fontWeight: FontWeight.w500,
                  color: textMedium,
                  height: 1.35,
                  letterSpacing: -0.08,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 12.0 * s),

              // Status Indicators
              Row(
                children: [
                  _buildStatusIndicator(
                      context, '0 Guests', Icons.people_outline_rounded, s),
                  SizedBox(width: 10.0 * s),
                  _buildStatusIndicator(
                      context, '0 Co-hosts', Icons.handshake_outlined, s),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(
      BuildContext context, String text, IconData icon, double s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0 * s, vertical: 6.0 * s),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0 * s),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.0 * s,
            color: Colors.black54,
          ),
          SizedBox(width: 6.0 * s),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 11.0 * s,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
              letterSpacing: -0.08,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactActionButtons(BuildContext context, double s) {
    return Row(
      children: [
        Expanded(
          child: _buildPrimaryActionButton(
              context, 'Invite Guests', Icons.person_add_alt_1_rounded, () {
            _showPremiumShareDialog(context);
          }, s),
        ),
        SizedBox(width: 12.0 * s),
        Expanded(
          child: _buildSecondaryActionButton(
              context, 'Add Co-Host', Icons.handshake_rounded, () {
            _pickMultipleContacts();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contacts share tapped')),
            );
          }, s),
        ),
      ],
    );
  }

  Widget _buildPrimaryActionButton(BuildContext context, String label,
      IconData icon, VoidCallback onTap, double s) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBurgundy,
              primaryBurgundy.withOpacity(0.92),
            ],
          ),
          borderRadius: BorderRadius.circular(12.0 * s),
          boxShadow: [
            BoxShadow(
              color: primaryBurgundy.withOpacity(0.24),
              blurRadius: 10.0 * s,
              offset: Offset(0, 4.0 * s),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.0 * s, color: primaryWhite),
            SizedBox(width: 8.0 * s),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.0 * s,
                fontWeight: FontWeight.w600,
                color: primaryWhite,
                letterSpacing: -0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryActionButton(BuildContext context, String label,
      IconData icon, VoidCallback onTap, double s) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.04,
        // width: MediaQuery.of(context).size.width * 0.850,
        decoration: BoxDecoration(
          color: primaryWhite,
          borderRadius: BorderRadius.circular(12.0 * s),
          border: Border.all(
            color: primaryBurgundy.withOpacity(0.18),
            width: 1.6 * s,
          ),
          boxShadow: [
            BoxShadow(
              color: secondaryYellow.withOpacity(0.14),
              blurRadius: 8.0 * s,
              offset: Offset(0, 2.0 * s),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.0 * s, color: primaryBurgundy),
            SizedBox(width: 8.0 * s),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.0 * s,
                fontWeight: FontWeight.w600,
                color: primaryBurgundy,
                letterSpacing: -0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPremiumShareDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, a1, a2, widget) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: screenWidth * 1.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 32,
                      offset: const Offset(0, 16),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Premium Header Section
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF9A2143).withOpacity(0.08),
                            const Color(0xFFF3ECE3).withOpacity(0.3),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Premium Close Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 32),
                              // Premium Icon
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF9A2143),
                                      Color(0xFF7A1B3A)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF9A2143)
                                          .withOpacity(0.3),
                                      blurRadius: 16,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.share_rounded,
                                  color: Colors.white,
                                  size: screenWidth * 0.06,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.black54,
                                    size: screenWidth * 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.02),

                          // Premium Title
                          Text(
                            "Invite People",
                            style: TextStyle(
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2C2C2C),
                              letterSpacing: -0.5,
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.008),

                          Text(
                            "Share your event with friends and family",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B6B6B),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content Section
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      child: Column(
                        children: [
                          // Premium Share Option 1
                          _buildPremiumShareTile(
                            context: context,
                            title: "Share To Grouping Contacts",
                            subtitle: "Send to multiple contact groups",
                            icon: Icons.group_rounded,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7B68EE), Color(0xFF9370DB)],
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              // Your grouping contacts logic here
                            },
                          ),

                          SizedBox(height: screenHeight * 0.025),

                          // Premium Divider
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.1),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                    vertical: screenHeight * 0.008,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8F9FA),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.08),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.028,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF6B6B6B),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.1),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.025),

                          // Premium Share Option 2
                          _buildPremiumShareTile(
                            context: context,
                            title: "Share To Contacts",
                            subtitle: "Select individual contacts",
                            icon: Icons.contacts_rounded,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1E88E5), Color(0xFF2196F3)],
                            ),
                            onTap: () {
                              _pickMultipleContacts();
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Contacts share tapped'),
                                  backgroundColor: const Color(0xFF9A2143),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPremiumShareTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black.withOpacity(0.06),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Premium Icon Container
            Container(
              padding: EdgeInsets.all(screenWidth * 0.035),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: screenWidth * 0.055,
              ),
            ),

            SizedBox(width: screenWidth * 0.04),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C2C2C),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.004),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B6B6B),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: const Color(0xFF6B6B6B),
                size: screenWidth * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickMultipleContacts() async {
    PermissionStatus status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
      if (!status.isGranted) {
        if (status.isPermanentlyDenied) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Permission required'),
              content: const Text(
                  'Please enable contacts permission in app settings to select contacts.'),
              actions: [
                TextButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: const Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
          return;
        } else {
          // Permission denied (not permanent)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contacts permission denied')),
          );
          return;
        }
      }
    }

    // Permission granted, fetch contacts
    bool flutterContactPermission = await FlutterContacts.requestPermission();
    if (!flutterContactPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacts permission denied')),
      );
      return;
    }

    List<Contact> contacts =
        await FlutterContacts.getContacts(withProperties: true);
    setState(() {
      _allContacts = contacts;
      //  _selectedContacts.clear();
    });

    // Open selection page
    final List<Contact>? results = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContactSelectionPage(
          contacts: _allContacts,
          initiallySelected: _selectedContacts,
        ),
      ),
    );

    // Get selected contacts result
    if (results != null) {
      setState(() {
        _selectedContacts = results;
      });

      for (var c in _selectedContacts) {
        print('Selected: ${c.displayName}');
      }
    }
  }

  Widget _shareTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black26)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.0, color: color),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
