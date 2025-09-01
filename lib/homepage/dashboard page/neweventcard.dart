import 'dart:async';
import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/3rd%20screen/maineventpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventSummaryCard extends StatefulWidget {
  final String eventName;
  final String eventType;
  final DateTime endsAt;        
  final int invitedCount;       
  final int totalGuests;   
  
  const EventSummaryCard({
    super.key,
    required this.eventName,
    required this.eventType,
    required this.endsAt,
    required this.invitedCount,
    required this.totalGuests,
  });

  @override
  State<EventSummaryCard> createState() => _EventSummaryCardState();
}

class _EventSummaryCardState extends State<EventSummaryCard> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = _calcRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final d = _calcRemaining();
      if (mounted) setState(() => _remaining = d);
    });
  }

  Duration _calcRemaining() {
    final now = DateTime.now();
    final diff = widget.endsAt.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  String _formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    final dd = days > 0 ? '$days d ' : '';
    return '$dd${hours.toString().padLeft(2, '0')}:'
           '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double ratio = (widget.totalGuests == 0)
        ? 0.0
        : (widget.invitedCount / widget.totalGuests).clamp(0.0, 1.0);

    final Color onBg      = const Color(0xFF2E2A22);     // Dark text on light bg
    final Color subText   = onBg.withOpacity(0.75);      // Subtle text
    final Color chipBg    = AppColors.boxboxlight;       // Soft chip bg
    final Color chipBorder= AppColors.boxdarkcolor.withOpacity(0.55);
    final Color iconColor = AppColors.buttoncolor;       // Accent for icons
    final Color barTrack  = onBg.withOpacity(0.12);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> demopage()));
        },
        child: Container(
          decoration: BoxDecoration(
             gradient: const LinearGradient(
               begin: Alignment.topLeft,
                      end: Alignment.topRight,
                          colors: [Color(0xFFEDD498),Colors.white,],
                          ),
            color: AppColors.boxboxlight, 
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: AppColors.boxboxlight.withOpacity(0.8), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: event name + type tag
                // SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          widget.eventName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: onBg, // << readable on light bg
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: _Badge(
                        label: widget.eventType,
                        bg: chipBg,
                        fg: onBg,
                        border: chipBorder,
                      ),
                    ),
                  ],
                ),
            
              //  const SizedBox(height: 6),
            
                // Time remaining
                Row(
                  children: [
                    Icon(Icons.schedule, color: iconColor, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      'Time remaining:',
                      style: GoogleFonts.inter(
                        color: subText,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        _remaining == Duration.zero
                            ? 'Ended'
                            : _formatDuration(_remaining),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ibmPlexSans(
                          color: onBg,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
            
               // const SizedBox(height: 6),
            
                // Guest invites + count
                Row(
                  children: [
                    Icon(Icons.group, color: iconColor, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      'Guest Invites',
                      style: GoogleFonts.inter(
                        color: subText,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.invitedCount}/${widget.totalGuests}',
                      style: GoogleFonts.ibmPlexSans(
                        color: onBg,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 6),
            
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: barTrack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LayoutBuilder(
                      builder: (context, c) => Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOut,
                          width: c.maxWidth * ratio,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.buttoncolor, AppColors.buttoncolor],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(height: 6),
            
                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Invite more (outline)
                    _OutlineChip(
                      icon: Icons.share_outlined,
                      label: 'Invite More',
                      fg: onBg,
                      border: chipBorder,
                      onTap: () {
                        // TODO: share / invite action
                      },
                    ),
                    const SizedBox(width: 10),
            
                    // My Events (solid primary)
                    MyEventsButton(
                      
                      bg: AppColors.buttoncolor,
                      fg: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 6.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color bg, fg, border;
  const _Badge({
    required this.label,
    required this.bg,
    required this.fg,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.w900,
         // letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _OutlineChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color fg, border;
  final VoidCallback onTap;
  const _OutlineChip({
    required this.icon,
    required this.label,
    required this.fg,
    required this.border,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: border, width: 1)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 16, color: fg),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyEventsButton extends StatelessWidget {
  final Color bg;
  final Color fg;
  const MyEventsButton({
    super.key,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> demopage()));
      },
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        decoration: BoxDecoration(
          color: bg, // solid primary button
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: Row(
          children: [
            Icon(Icons.event_available, size: 16, color: AppColors.buttoncolor),
            const SizedBox(width: 4),
            Text(
              "My Events",
              style: GoogleFonts.dmSans(
                color: AppColors.buttoncolor,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
