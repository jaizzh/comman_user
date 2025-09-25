import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/dashboard%20page/view_invite/myinviteevents.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// Constants for responsive design
class AppConstants {
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Responsive breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;

  // UI Constants
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double iconSize = 22.0;
  static const int maxEventColors = 8;
}

// Responsive helper class
class ResponsiveHelper {
  static double getFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < AppConstants.mobileBreakpoint) {
      return baseSize * 0.9;
    } else if (screenWidth < AppConstants.tabletBreakpoint) {
      return baseSize;
    } else {
      return baseSize * 1.1;
    }
  }

  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }
}

// Data model for events
class EventModel {
  final String eventName;
  final String eventType;
  final String startDate;
  final String endDate;
  final int? inviteFrom;
  final bool isAccepted;

  const EventModel({
    required this.eventName,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    this.inviteFrom,
    this.isAccepted = false,
  });

  factory EventModel.fromMap(Map<dynamic, dynamic> map) {
    return EventModel(
      eventName: map['eventname']?.toString() ?? '',
      eventType: map['eventtype']?.toString() ?? '',
      startDate: map['startdate']?.toString() ?? '',
      endDate: map['enddate']?.toString() ?? '',
      inviteFrom: map['invitefrom'] as int?,
      isAccepted: map['isAccepted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventname': eventName,
      'eventtype': eventType,
      'startdate': startDate,
      'enddate': endDate,
      'invitefrom': inviteFrom,
      'isAccepted': isAccepted,
    };
  }

  EventModel copyWith({
    String? eventName,
    String? eventType,
    String? startDate,
    String? endDate,
    int? inviteFrom,
    bool? isAccepted,
  }) {
    return EventModel(
      eventName: eventName ?? this.eventName,
      eventType: eventType ?? this.eventType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      inviteFrom: inviteFrom ?? this.inviteFrom,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }
}

// Colored range model for calendar
class ColoredRange {
  final DateTimeRange range;
  final Color color;
  final String label;

  const ColoredRange({
    required this.range,
    required this.color,
    required this.label,
  });
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Sample data converted to models
  final List<EventModel> _inviteEventList = [
    const EventModel(
      eventName: "Vini Birthday Party",
      eventType: "Birthday Party",
      startDate: "06/09/2025",
      endDate: "08/09/2025",
      inviteFrom: 9500427658,
    ),
    const EventModel(
      eventName: "Prakash & Anu Wedding Anniversary",
      eventType: "Wedding Anniversary",
      startDate: "07/09/2025",
      endDate: "12/09/2025",
      inviteFrom: 8838185633,
    ),
  ];

  final List<EventModel> _inviteAcceptList = <EventModel>[];

  // Selected date for showing events
  DateTime? _selectedDay;

  // Color constants
  static const Color _kBrand = Color(0xFF9A2143);
  static const Color _kBrandLight = Color(0xFFEFD6DE);
  static const Color _kInk = Color(0xFF111111);
  static const Color _kMuted = Color(0xFF6B6B6B);

  // Date formatter
  final DateFormat _dateFormatter = DateFormat('dd/MM/yyyy');

  // Color palette for events
  static const List<Color> _eventColorPalette = [
    Color(0xFF9A2143), // brand burgundy
    Color(0xFF0D9488), // teal
    Color(0xFF4F46E5), // indigo
    Color(0xFFF59E0B), // amber
    Color(0xFF9333EA), // purple
    Color(0xFFDB2777), // pink
    Color(0xFF16A34A), // green
    Color(0xFF2563EB), // blue
  ];

  // Helper methods
  DateTime _dateOnly(DateTime date) => DateUtils.dateOnly(date);

  DateTime _parseDate(String dateString) {
    try {
      final dt = _dateFormatter.parseStrict(dateString);
      return DateTime(dt.year, dt.month, dt.day);
    } catch (e) {
      debugPrint('Error parsing date: $dateString');
      return DateTime.now();
    }
  }

  bool _isDateInRange(DateTime date, DateTimeRange range) {
    final dateOnly = _dateOnly(date);
    return (dateOnly.isAfter(range.start) ||
            dateOnly.isAtSameMomentAs(range.start)) &&
        (dateOnly.isBefore(range.end) || dateOnly.isAtSameMomentAs(range.end));
  }

  bool _isStartOfRange(DateTime date, DateTimeRange range) =>
      isSameDay(_dateOnly(date), range.start);

  bool _isEndOfRange(DateTime date, DateTimeRange range) =>
      isSameDay(_dateOnly(date), range.end);

  // Get all events for a specific date
  List<EventModel> _getEventsForDate(DateTime date) {
    final List<EventModel> eventsForDay = [];
    final allEvents = [..._inviteEventList, ..._inviteAcceptList];

    for (final event in allEvents) {
      final startDate = _parseDate(event.startDate);
      final endDate = _parseDate(event.endDate);

      final start = startDate.isAfter(endDate)
          ? _dateOnly(endDate)
          : _dateOnly(startDate);
      final end = startDate.isAfter(endDate)
          ? _dateOnly(startDate)
          : _dateOnly(endDate);

      final eventRange = DateTimeRange(start: start, end: end);

      if (_isDateInRange(date, eventRange)) {
        eventsForDay.add(event);
      }
    }

    return eventsForDay;
  }

  // Build colored ranges for calendar
  List<ColoredRange> _buildColoredRanges() {
    final allEvents = _inviteAcceptList;
    final List<ColoredRange> ranges = [];

    for (int i = 0; i < allEvents.length; i++) {
      final event = allEvents[i];
      final startDate = _parseDate(event.startDate);
      final endDate = _parseDate(event.endDate);

      final start = startDate.isAfter(endDate)
          ? _dateOnly(endDate)
          : _dateOnly(startDate);
      final end = startDate.isAfter(endDate)
          ? _dateOnly(startDate)
          : _dateOnly(endDate);

      final color = _eventColorPalette[i % _eventColorPalette.length];

      ranges.add(ColoredRange(
        range: DateTimeRange(start: start, end: end),
        color: color,
        label: event.eventName,
      ));
    }

    return ranges;
  }

  ColoredRange? _getPrimaryRangeForDay(
      DateTime day, List<ColoredRange> ranges) {
    for (final range in ranges) {
      if (_isDateInRange(day, range.range)) return range;
    }
    return null;
  }

  List<ColoredRange> _getAllRangesForDay(
      DateTime day, List<ColoredRange> ranges) {
    return ranges.where((range) => _isDateInRange(day, range.range)).toList();
  }

  // Handle day selection and show events popup
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });

    final eventsForDay = _getEventsForDate(selectedDay);

    if (eventsForDay.isNotEmpty) {
      _showEventsPopup(selectedDay, eventsForDay);
    }
  }

  // Show events popup for selected date
  void _showEventsPopup(DateTime date, List<EventModel> events) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEventsBottomSheet(date, events),
    );
  }

  // Build events bottom sheet
  Widget _buildEventsBottomSheet(DateTime date, List<EventModel> events) {
    final formattedDate = _dateFormatter.format(date);

    return Container(
      height: ResponsiveHelper.getResponsiveHeight(context, 0.8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.defaultBorderRadius),
          topRight: Radius.circular(AppConstants.defaultBorderRadius),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Events on',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 14),
                          color: _kMuted,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          color: _kInk,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Events list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: events.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildEventPopupCard(context, events[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build event card for popup
  Widget _buildEventPopupCard(
      BuildContext context, EventModel event, int index) {
    final color = _eventColorPalette[index % _eventColorPalette.length];

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
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
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.eventName,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                        color: _kInk,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.eventType,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 14),
                        color: _kMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: event.isAccepted
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  event.isAccepted ? 'Accepted' : 'Pending',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(context, 12),
                    fontWeight: FontWeight.w600,
                    color: event.isAccepted
                        ? Colors.green[700]
                        : Colors.orange[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16,
                color: _kMuted,
              ),
              const SizedBox(width: 8),
              Text(
                '${event.startDate} - ${event.endDate}',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 14),
                  color: _kMuted,
                ),
              ),
            ],
          ),
          if (event.inviteFrom != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 16,
                  color: _kMuted,
                ),
                const SizedBox(width: 8),
                Text(
                  'From: ${event.inviteFrom}',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(context, 14),
                    color: _kMuted,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildCalendar(context),
            _buildInviteList(context),
            MyInviteEvents(
                completelistinvite:
                    _inviteAcceptList.map((e) => e.toMap()).toList()),
          ],
        ),
      ),
    );
  }

  // App bar widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: AppColors.primary,
      surfaceTintColor: Colors.white,
      elevation: 0,
      toolbarHeight: screenHeight * 0.07,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          size: ResponsiveHelper.isMobile(context)
              ? screenWidth * 0.055
              : AppConstants.iconSize,
        ),
      ),
      title: Text(
        "Event Invites",
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(context, 18),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        _buildAppBarAction(context, Icons.notifications_active_rounded, () {}),
        _buildAppBarAction(context, Icons.history_rounded, () {}),
        SizedBox(width: ResponsiveHelper.getResponsiveWidth(context, 0.02)),
      ],
    );
  }

  Widget _buildAppBarAction(
      BuildContext context, IconData icon, VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;

    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
        size: ResponsiveHelper.isMobile(context)
            ? screenWidth * 0.055
            : AppConstants.iconSize,
      ),
    );
  }

  // Calendar widget
  Widget _buildCalendar(BuildContext context) {
    final ranges = _buildColoredRanges();
    final focusedDay =
        ranges.isNotEmpty ? ranges.first.range.start : DateTime.now();

    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: TableCalendar<void>(
          daysOfWeekStyle: _buildDaysOfWeekStyle(context),
          daysOfWeekHeight: ResponsiveHelper.isMobile(context) ? 30 : 35,
          calendarStyle: _buildCalendarStyle(context),
          headerStyle: _buildHeaderStyle(context),
          focusedDay: focusedDay,
          firstDay: DateTime.utc(2020, 10, 1),
          lastDay: DateTime(2030, 10, 1),
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: _onDaySelected,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) =>
                _buildCalendarDay(context, day, ranges),
            selectedBuilder: (context, day, focusedDay) =>
                _buildSelectedCalendarDay(context, day, ranges),
          ),
        ),
      ),
    );
  }

  DaysOfWeekStyle _buildDaysOfWeekStyle(BuildContext context) {
    return DaysOfWeekStyle(
      weekdayStyle: GoogleFonts.lobster(
        fontSize: ResponsiveHelper.getFontSize(context, 13),
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      weekendStyle: GoogleFonts.lobster(
        fontSize: ResponsiveHelper.getFontSize(context, 13),
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  CalendarStyle _buildCalendarStyle(BuildContext context) {
    return CalendarStyle(
      isTodayHighlighted: true,
      todayDecoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      selectedDecoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      outsideDaysVisible: false,
      defaultTextStyle: GoogleFonts.lobster(
        fontSize: ResponsiveHelper.getFontSize(context, 13),
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      weekendTextStyle: GoogleFonts.lobster(
        fontSize: ResponsiveHelper.getFontSize(context, 13),
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  HeaderStyle _buildHeaderStyle(BuildContext context) {
    return HeaderStyle(
      leftChevronIcon: Icon(
        Icons.arrow_left_rounded,
        size: ResponsiveHelper.isMobile(context) ? 35 : 40,
        color: AppColors.primary,
      ),
      rightChevronIcon: Icon(
        Icons.arrow_right_rounded,
        size: ResponsiveHelper.isMobile(context) ? 35 : 40,
        color: AppColors.primary,
      ),
      titleTextStyle: TextStyle(
        fontSize: ResponsiveHelper.getFontSize(context, 16),
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      titleCentered: true,
      formatButtonVisible: false,
    );
  }

  Widget _buildCalendarDay(
      BuildContext context, DateTime day, List<ColoredRange> ranges) {
    final primary = _getPrimaryRangeForDay(day, ranges);
    final overlaps = _getAllRangesForDay(day, ranges);
    final hasEvents = _getEventsForDate(day).isNotEmpty;

    BorderRadius radius = BorderRadius.zero;
    if (primary != null) {
      final isStart = _isStartOfRange(day, primary.range);
      final isEnd = _isEndOfRange(day, primary.range);

      if (isStart && isEnd) {
        radius = BorderRadius.circular(999);
      } else if (isStart) {
        radius = const BorderRadius.horizontal(left: Radius.circular(999));
      } else if (isEnd) {
        radius = const BorderRadius.horizontal(right: Radius.circular(999));
      }
    }

    return Stack(
      children: [
        // Background pill
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          decoration: primary != null
              ? BoxDecoration(
                  color: primary.color.withOpacity(0.16),
                  borderRadius: radius,
                )
              : hasEvents
                  ? BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    )
                  : null,
          child: Center(
            child: Container(
              decoration: (primary != null &&
                      (_isStartOfRange(day, primary.range) ||
                          _isEndOfRange(day, primary.range)))
                  ? BoxDecoration(
                      color: primary.color,
                      shape: BoxShape.circle,
                    )
                  : null,
              padding: (primary != null &&
                      (_isStartOfRange(day, primary.range) ||
                          _isEndOfRange(day, primary.range)))
                  ? const EdgeInsets.all(6)
                  : EdgeInsets.zero,
              child: Text(
                '${day.day}',
                style: GoogleFonts.lobster(
                  fontSize: ResponsiveHelper.getFontSize(context, 13),
                  fontWeight: (primary != null &&
                          (_isStartOfRange(day, primary.range) ||
                              _isEndOfRange(day, primary.range)))
                      ? FontWeight.w800
                      : FontWeight.w600,
                  color: (primary != null &&
                          (_isStartOfRange(day, primary.range) ||
                              _isEndOfRange(day, primary.range)))
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
          ),
        ),
        // Event indicator for non-range events
        if (hasEvents && primary == null)
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        // Overlap indicators
        if (overlaps.length > 1) _buildOverlapIndicators(overlaps),
      ],
    );
  }

  Widget _buildSelectedCalendarDay(
      BuildContext context, DateTime day, List<ColoredRange> ranges) {
    final primary = _getPrimaryRangeForDay(day, ranges);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      decoration: BoxDecoration(
        color: primary?.color ?? AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: GoogleFonts.lobster(
            fontSize: ResponsiveHelper.getFontSize(context, 13),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildOverlapIndicators(List<ColoredRange> overlaps) {
    return Positioned(
      bottom: 4,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: overlaps.take(3).map((range) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: range.color,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 0.5,
                  color: Colors.black26,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Invite list widget (rest of the methods remain the same)
  Widget _buildInviteList(BuildContext context) {
    if (_inviteEventList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInviteListHeader(context),
          const SizedBox(height: AppConstants.defaultPadding),
          _buildInviteItems(context),
        ],
      ),
    );
  }

  Widget _buildInviteListHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Invited Events",
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 16),
            fontWeight: FontWeight.w800,
            color: _kInk,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "The events below come from unknown numbers—the hosts would love to celebrate with you",
          maxLines: 2,
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 12),
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildInviteItems(BuildContext context) {
    return ListView.separated(
      itemCount: _inviteEventList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildInviteCard(context, index);
      },
    );
  }

  Widget _buildInviteCard(BuildContext context, int index) {
    final event = _inviteEventList[index];

    return Card(
      elevation: 3.0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildEventHeader(context, event),
            const SizedBox(height: AppConstants.smallPadding),
            _buildEventDates(context, event),
            const SizedBox(height: AppConstants.smallPadding),
            _buildEventActions(context, index),
          ],
        ),
      ),
    );
  }

  Widget _buildEventHeader(BuildContext context, EventModel event) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: _kBrandLight,
            borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
          ),
          child: const Icon(
            Icons.event_available_rounded,
            color: _kBrand,
            size: AppConstants.iconSize,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.eventName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 15),
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              Text(
                event.eventType,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 13),
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventDates(BuildContext context, EventModel event) {
    return Row(
      children: [
        _buildDateChip(
          context,
          icon: Icons.calendar_today_outlined,
          label: event.startDate,
        ),
        const SizedBox(width: 6),
        _buildSeparatorDot(),
        const SizedBox(width: 6),
        _buildDateChip(context, label: event.endDate),
      ],
    );
  }

  Widget _buildDateChip(BuildContext context,
      {required String label, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x11000000)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: _kMuted),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 12.5),
              fontWeight: FontWeight.w600,
              color: _kInk,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparatorDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: _kMuted,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildEventActions(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildActionButton(
          context,
          label: "Decline",
          icon: Icons.close,
          color: AppColors.primary,
          backgroundColor: Colors.white,
          onTap: () => _showDeclineDialog(context, index),
        ),
        const SizedBox(width: 14),
        _buildActionButton(
          context,
          label: "Accept",
          icon: Icons.check_circle_outline,
          color: Colors.white,
          backgroundColor: AppColors.primary,
          onTap: () => _showAcceptDialog(context, index),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.isMobile(context) ? 16 : 20,
          vertical: ResponsiveHelper.isMobile(context) ? 4 : 6,
        ),
        decoration: BoxDecoration(
          border: backgroundColor == Colors.white
              ? Border.all(color: AppColors.primary, width: 1.0)
              : null,
          borderRadius: BorderRadius.circular(6.0),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20.0, color: color),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 14),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog methods
  Future<void> _showDeclineDialog(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => _buildActionDialog(
        context,
        title: "Event Decline",
        message: "Do you really want to decline the event?",
        actionLabel: "Decline",
        actionColor: Colors.red,
        onAction: () {
          setState(() {
            _inviteEventList.removeAt(index);
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _showAcceptDialog(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => _buildActionDialog(
        context,
        title: "Event Accept",
        message: "Do you want to participate in the invited event?",
        actionLabel: "Yes",
        actionColor: Colors.green,
        onAction: () {
          setState(() {
            final event = _inviteEventList.removeAt(index);
            _inviteAcceptList.add(event.copyWith(isAccepted: true));
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildActionDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String actionLabel,
    required Color actionColor,
    required VoidCallback onAction,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 14),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: actionColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    actionLabel,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
