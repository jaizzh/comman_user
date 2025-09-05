import 'package:common_user/app_colors.dart';
import 'package:common_user/features/venue/presentation/pages/fill_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckAvailability extends StatefulWidget {
  const CheckAvailability({super.key});

  @override
  State<CheckAvailability> createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {
  DateTime focusedDay = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  // Fully booked dates (no availability)
  final List<DateTime> bookedDates = [
    DateTime.utc(2025, 9, 5),
    DateTime.utc(2025, 9, 10),
    DateTime.utc(2025, 9, 16),
  ];

  // Partially booked dates (morning OR evening booked, one slot available)
  final List<DateTime> offBookedDates = [
    DateTime.utc(2025, 9, 6),
    DateTime.utc(2025, 9, 11),
    DateTime.utc(2025, 9, 17),
  ];

  bool isFullyBooked(DateTime day) {
    return bookedDates.any((d) => isSameDay(d, day));
  }

  bool isPartiallyBooked(DateTime day) {
    return offBookedDates.any((d) => isSameDay(d, day));
  }

  bool hasFullyBookedDatesInRange(DateTime start, DateTime end) {
    DateTime currentDate = start;
    while (currentDate.isBefore(end) || isSameDay(currentDate, end)) {
      if (isFullyBooked(currentDate)) {
        return true;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return false;
  }

  List<DateTime> getFullyBookedDatesInRange(DateTime start, DateTime end) {
    List<DateTime> fullyBookedInRange = [];
    DateTime currentDate = start;
    while (currentDate.isBefore(end) || isSameDay(currentDate, end)) {
      if (isFullyBooked(currentDate)) {
        fullyBookedInRange.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return fullyBookedInRange;
  }

  List<DateTime> getPartiallyBookedDatesInRange(DateTime start, DateTime end) {
    List<DateTime> partiallyBookedInRange = [];
    DateTime currentDate = start;
    while (currentDate.isBefore(end) || isSameDay(currentDate, end)) {
      if (isPartiallyBooked(currentDate)) {
        partiallyBookedInRange.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return partiallyBookedInRange;
  }

  void showBookingInfoSnackBar(
      List<DateTime> fullyBooked, List<DateTime> partiallyBooked) {
    String message = "";

    if (fullyBooked.isNotEmpty) {
      String fullyBookedDates = fullyBooked
          .map((date) => "${date.day}/${date.month}/${date.year}")
          .join(", ");
      message = 'These dates are fully booked: $fullyBookedDates';
    }

    if (partiallyBooked.isNotEmpty) {
      String partiallyBookedDates = partiallyBooked
          .map((date) => "${date.day}/${date.month}/${date.year}")
          .join(", ");

      if (message.isNotEmpty) {
        message +=
            '\n\nPartially available (morning or evening): $partiallyBookedDates';
      } else {
        message =
            'These dates have partial availability (morning or evening): $partiallyBookedDates';
      }
    }

    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor:
              fullyBooked.isNotEmpty ? Colors.redAccent : Colors.green,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    // Responsive values
    final horizontalPadding = size.width * 0.04;
    final verticalSpacing = size.height * 0.015;
    final cardPadding = size.width * 0.03;

    return Scaffold(
      appBar: _buildAppBar(context, size),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightGold, Colors.white],
            stops: [0.0, 0.40],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context, size),
                SizedBox(height: verticalSpacing),
                _buildLegendCard(context, size, cardPadding),
                SizedBox(height: verticalSpacing),
                _buildCalendar(context, size, isTablet),
                SizedBox(height: verticalSpacing),
                _buildDateSelection(
                    context, size, cardPadding, verticalSpacing),
                SizedBox(height: verticalSpacing * 1.5),
                _buildContinueButton(context, size),
                SizedBox(height: verticalSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Size size) {
    return AppBar(
      backgroundColor: AppColors.lightGold,
      surfaceTintColor: AppColors.lightGold,
      elevation: 0,
      title: Text(
        "Check Availability",
        style: GoogleFonts.poppins(
          fontSize: size.width > 600 ? 18 : 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.04),
          child: Icon(
            Icons.calendar_month,
            color: AppColors.primary,
            size: size.width > 600 ? 28 : 24,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, Size size) {
    return Text(
      "Choose Your Dates",
      style: GoogleFonts.poppins(
        fontSize: size.width > 600 ? 18 : 16,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildLegendCard(BuildContext context, Size size, double cardPadding) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: cardPadding,
          vertical: size.height * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child:
                    _buildLegendItem("Available", LegendType.available, size)),
            Expanded(
                child: _buildLegendItem("Partial", LegendType.partial, size)),
            Expanded(
                child: _buildLegendItem("Booked", LegendType.booked, size)),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, LegendType type, Size size) {
    final iconSize = size.width > 600 ? 20.0 : 16.0;
    final fontSize = size.width > 600 ? 14.0 : 12.0;

    Widget icon;
    switch (type) {
      case LegendType.available:
        icon = Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 2),
          ),
        );
        break;
      case LegendType.partial:
        icon = Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 2),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.white, Colors.orange],
              stops: [0.50, 0.60],
            ),
          ),
        );
        break;
      case LegendType.booked:
        icon = Container(
          width: iconSize + 4,
          height: iconSize + 4,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/png/closed.png"),
              fit: BoxFit.contain,
            ),
          ),
        );
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(width: size.width * 0.02),
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar(BuildContext context, Size size, bool isTablet) {
    return Card(
      elevation: 6,
      shadowColor: AppColors.lightGold.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          rangeSelectionMode: rangeSelectionMode,
          rangeStartDay: rangeStart,
          rangeEndDay: rangeEnd,
          onRangeSelected: _handleRangeSelection,
          onDaySelected: _handleDaySelection,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.bold,
            ),
            formatButtonVisible: false,
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: AppColors.primary,
              size: isTablet ? 28 : 24,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: AppColors.primary,
              size: isTablet ? 28 : 24,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: isTablet ? 14 : 12,
              fontWeight: FontWeight.w500,
            ),
            weekendStyle: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: isTablet ? 14 : 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          calendarStyle: CalendarStyle(
            cellMargin: EdgeInsets.all(size.width * 0.005),
            defaultTextStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: isTablet ? 16 : 14,
            ),
            weekendTextStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: isTablet ? 16 : 14,
            ),
            outsideTextStyle: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: isTablet ? 16 : 14,
            ),
            todayTextStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
            todayDecoration: const BoxDecoration(
              color: Color.fromARGB(255, 239, 165, 186),
              shape: BoxShape.circle,
            ),
            selectedTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
            selectedDecoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            rangeStartDecoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            rangeStartTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
            rangeEndTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
            withinRangeDecoration: const BoxDecoration(
              color: Color.fromARGB(100, 239, 165, 186),
              shape: BoxShape.rectangle,
            ),
            withinRangeTextStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: isTablet ? 16 : 14,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) =>
                _buildCustomDayCell(day, size),
            rangeStartBuilder: (context, day, focusedDay) =>
                _buildCustomDayCell(day, size),
            rangeEndBuilder: (context, day, focusedDay) =>
                _buildCustomDayCell(day, size),
            withinRangeBuilder: (context, day, focusedDay) =>
                _buildCustomDayCell(day, size),
          ),
        ),
      ),
    );
  }

  Widget? _buildCustomDayCell(DateTime day, Size size) {
    final cellSize = size.width > 600 ? 45.0 : 40.0;
    final fontSize = size.width > 600 ? 16.0 : 14.0;

    if (isFullyBooked(day)) {
      return _buildFullyBookedDayCell(day, cellSize, fontSize);
    } else if (isPartiallyBooked(day)) {
      return _buildPartiallyBookedDayCell(day, cellSize, fontSize);
    }
    return null;
  }

  Widget _buildFullyBookedDayCell(DateTime day, double size, double fontSize) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/closed.png"),
            fit: BoxFit.contain,
          ),
        ),
        width: size,
        height: size,
        child: Center(
          child: Text(
            '${day.day}',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPartiallyBookedDayCell(
      DateTime day, double size, double fontSize) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.orange, width: 2),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.white, Colors.orange],
            stops: [0.50, 0.60],
          ),
        ),
        width: size,
        height: size,
        child: Center(
          child: Text(
            '${day.day}',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context, Size size,
      double cardPadding, double verticalSpacing) {
    return Column(
      children: [
        _buildDateCard("Start Date", rangeStart, size, cardPadding),
        SizedBox(height: verticalSpacing),
        _buildDateCard("End Date", rangeEnd, size, cardPadding),
      ],
    );
  }

  Widget _buildDateCard(
      String label, DateTime? date, Size size, double cardPadding) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(cardPadding),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.paper,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: size.width > 600 ? 14 : 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              formatDate(date),
              style: GoogleFonts.poppins(
                fontSize: size.width > 600 ? 18 : 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, Size size) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: rangeStart != null && rangeEnd != null
            ? () {
                // Handle continue action
                print(
                    'Continue with dates: ${formatDate(rangeStart)} to ${formatDate(rangeEnd)}');
              }
            : null,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            if (rangeStart != null && rangeEnd != null) {
              // In the _buildContinueButton method, replace the Navigator.push section:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FillDetails(
                    startDate: rangeStart!,
                    endDate: rangeEnd!,
                    offBookedDates:
                        offBookedDates, // Pass the partially booked dates
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: rangeStart != null && rangeEnd != null
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Continue",
                  style: GoogleFonts.poppins(
                    fontSize: size.width > 600 ? 18 : 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: size.width > 600 ? 24 : 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRangeSelection(
      DateTime? start, DateTime? end, DateTime focusedDay) {
    if (start != null && end != null) {
      if (hasFullyBookedDatesInRange(start, end)) {
        List<DateTime> fullyBooked = getFullyBookedDatesInRange(start, end);
        showBookingInfoSnackBar(fullyBooked, []);
        return;
      }

      List<DateTime> partiallyBooked =
          getPartiallyBookedDatesInRange(start, end);
      if (partiallyBooked.isNotEmpty) {
        showBookingInfoSnackBar([], partiallyBooked);
      }

      setState(() {
        rangeStart = start;
        rangeEnd = end;
        this.focusedDay = focusedDay;
      });
    } else if (start != null && end == null) {
      if (isFullyBooked(start)) {
        showBookingInfoSnackBar([start], []);
        return;
      }

      List<DateTime> partiallyBooked = [];
      if (isPartiallyBooked(start)) {
        partiallyBooked.add(start);
        showBookingInfoSnackBar([], partiallyBooked);
      }

      setState(() {
        rangeStart = start;
        rangeEnd = start;
        this.focusedDay = focusedDay;
      });
    }
  }

  void _handleDaySelection(DateTime selectedDay, DateTime focusedDay) {
    if (rangeSelectionMode == RangeSelectionMode.toggledOff) {
      setState(() {
        this.focusedDay = focusedDay;
      });
    }
  }
}

enum LegendType { available, partial, booked }
