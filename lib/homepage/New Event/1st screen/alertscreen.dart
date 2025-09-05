import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.black87.withOpacity(0.75)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    )),
              //  const SizedBox(height: 1),
                Text(
                  value.isEmpty ? '—' : value,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium animated preview dialog
Future<void> EventScheduleDialog(
  BuildContext context, {
  required String eventName,
  required String eventCategory,
  required String startDate, // pass as dd-MM-yyyy string (your code already has startPretty)
  required String endDate,   // pass as dd-MM-yyyy string (your code already has endPretty)
  required int? eventDays,
  required String mobile,
  required String organizerName,
  required String email,
  required String address,
  VoidCallback? onConfirm,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Preview',
    barrierColor: Colors.black.withOpacity(0.35),
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, __) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1.0).animate(curved),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFEDD498), // boxlightcolor
                                Color(0xFFBFA054), // boxboxlight
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.85),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.event, size:16, color: Colors.black87),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Preview your event',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              // days chip
                              if (eventDays != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.timelapse, size: 14, color: Colors.black87),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${eventDays} day${eventDays == 1 ? '' : 's'}',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // body
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.0,),
                              _InfoRow(
                                icon: Icons.category_rounded,
                                label: 'Event Type',
                                value: eventCategory,
                              ),
                               SizedBox(height: 6.0,),
                              _InfoRow(
                                icon: Icons.badge_rounded,
                                label: 'Event Name',
                                value: eventName,
                              ),
                              SizedBox(height: 6.0,),
                              _InfoRow(
                                icon: Icons.calendar_month_rounded,
                                label: 'Start Date',
                                value: startDate,
                              ),
                              SizedBox(height: 6.0,),
                              _InfoRow(
                                icon: Icons.calendar_month_outlined,
                                label: 'End Date',
                                value: endDate,
                              ),
                              SizedBox(height: 6.0,),
                              const Divider(height: 18),
                              _InfoRow(
                                icon: Icons.phone_rounded,
                                label: 'Mobile',
                                value: mobile,
                              ),
                              SizedBox(height: 6.0,),
                              _InfoRow(
                                icon: Icons.person_pin_circle_rounded,
                                label: 'Organizer',
                                value: organizerName,
                              ),
                              SizedBox(height: 6.0,),
                              _InfoRow(
                                icon: Icons.alternate_email_rounded,
                                label: 'Email',
                                value: email,
                              ),
                              SizedBox(height: 6.0,),
                              _InfoRow(
                                icon: Icons.location_on_rounded,
                                label: 'Address',
                                value: address,
                              ),
                              SizedBox(height: 6.0,),
                               Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8.0),
                                    ),
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text(
                                      'Edit',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                        fontSize: 12.0
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF9A2143), // AppColors.buttoncolor
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8.0),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      onConfirm?.call();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Create Event',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            fontSize: 12.0
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,)
                            ],
                          ),
                        ),

                        // footer buttons
                       
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
