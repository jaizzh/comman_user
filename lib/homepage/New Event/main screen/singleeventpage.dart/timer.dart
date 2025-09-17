import 'dart:async';
import 'package:common_user/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumCountdownContainer extends StatefulWidget {
  final Duration initialDuration;

  const PremiumCountdownContainer({
    Key? key,
    required this.initialDuration,
  }) : super(key: key);

  @override
  State<PremiumCountdownContainer> createState() =>
      _PremiumCountdownContainerState();
}

class _PremiumCountdownContainerState extends State<PremiumCountdownContainer> {
  bool eventcomplete = true;
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.initialDuration;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 0) {
        timer.cancel();
        setState(() {
          eventcomplete = false;
        });
      } else {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxHeight = size.height * 0.04; // Constrain height
    final isSmallScreen = size.width < 400;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          eventcomplete = !eventcomplete;
        });
      },
      child: Container(
        /// height: maxHeight,
        // constraints: BoxConstraints(
        //  maxHeight: maxHeight,
        // maxWidth: size.width * 0.85, // Prevent overflow
        //     ),
        child: eventcomplete
            ? _buildCountdownView(isSmallScreen, maxHeight)
            : _buildGiftView(isSmallScreen, maxHeight),
      ),
    );
  }

  Widget _buildCountdownView(bool isSmallScreen, double maxHeight) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Container(
      height: maxHeight,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _compactTimeBlock(
              number: days,
              label: 'Day',
              isSmallScreen: isSmallScreen,
            ),
            _compactColon(isSmallScreen),
            _compactTimeBlock(
              number: hours,
              label: 'Hour',
              isSmallScreen: isSmallScreen,
            ),
            _compactColon(isSmallScreen),
            _compactTimeBlock(
              number: minutes,
              label: 'Min',
              isSmallScreen: isSmallScreen,
            ),
            _compactColon(isSmallScreen),
            _compactTimeBlock(
              number: seconds,
              label: 'Sec',
              isSmallScreen: isSmallScreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftView(bool isSmallScreen, double maxHeight) {
    return Container(
      height: maxHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 8 : 12,
        vertical: isSmallScreen ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gift Icon
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
            decoration: BoxDecoration(
              color: AppColors.buttoncolor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.card_giftcard_rounded,
              color: AppColors.buttoncolor,
              size: isSmallScreen ? 14 : 16,
            ),
          ),

          SizedBox(width: isSmallScreen ? 6 : 8),

          // Text Content
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Send Gifts",
                    style: GoogleFonts.inter(
                      fontSize: isSmallScreen ? 11 : 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.buttoncolor,
                      height: 1.1,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "to your guests",
                    style: GoogleFonts.inter(
                      fontSize: isSmallScreen ? 9 : 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: isSmallScreen ? 4 : 6),

          // Share Icon
          Icon(
            Icons.share_rounded,
            size: isSmallScreen ? 12 : 14,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  Widget _compactTimeBlock({
    required int number,
    required String label,
    required bool isSmallScreen,
  }) {
    return Container(
      constraints: BoxConstraints(
        minWidth: isSmallScreen ? 20 : 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number.toString().padLeft(2, '0'),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: isSmallScreen ? 12 : 14,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.8),
              fontSize: isSmallScreen ? 8 : 9,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _compactColon(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 2 : 3),
      child: Text(
        ':',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: isSmallScreen ? 12 : 14,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
