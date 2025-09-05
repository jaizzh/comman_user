import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FillDetails extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> offBookedDates;

  const FillDetails({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.offBookedDates,
  });

  @override
  State<FillDetails> createState() => _FillDetailsState();
}

class _FillDetailsState extends State<FillDetails> {
  List<DateTime> dateRange = [];
  Map<int, String> selectedTimeSlots = {};

  @override
  void initState() {
    super.initState();
    _generateDateRange();
    _initializeTimeSlots();
  }

  void _generateDateRange() {
    dateRange.clear();
    DateTime currentDate = widget.startDate;

    while (currentDate.isBefore(widget.endDate.add(const Duration(days: 1)))) {
      dateRange.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  void _initializeTimeSlots() {
    for (int i = 0; i < dateRange.length; i++) {
      DateTime date = dateRange[i];
      bool isPartiallyBooked = widget.offBookedDates.any((d) =>
          d.year == date.year && d.month == date.month && d.day == date.day);

      if (isPartiallyBooked) {
        // For partially booked dates, default to "Evening"
        selectedTimeSlots[i] = "Evening";
      } else {
        // For fully available dates, default to "Full Day"
        selectedTimeSlots[i] = "Full Day";
      }
    }
  }

  List<String> _getAvailableOptions(DateTime date) {
    bool isPartiallyBooked = widget.offBookedDates.any((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day);

    if (isPartiallyBooked) {
      // Only morning and evening for partially booked dates
      return ["Morning", "Evening"];
    } else {
      // All options for fully available dates
      return ["Full Day", "Morning", "Evening"];
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGold,
        surfaceTintColor: AppColors.lightGold,
        title: Text(
          "Check Availability",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.calendar_month,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightGold, Colors.white],
            stops: [0.0, 0.40],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fill the form to check availability",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Date Range Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Start Date"),
                      dates(_formatDate(widget.startDate), screenWidth / 2.5),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("End Date"),
                      dates(_formatDate(widget.endDate), screenWidth / 2.5),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Time Slots Section
              text("Choose Time"),
              const SizedBox(height: 10),

              // Dynamic dropdowns based on date range
              ...List.generate(dateRange.length, (index) {
                DateTime currentDate = dateRange[index];
                bool isPartiallyBooked = widget.offBookedDates.any((d) =>
                    d.year == currentDate.year &&
                    d.month == currentDate.month &&
                    d.day == currentDate.day);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        text("Day ${index + 1}"),
                        const SizedBox(width: 8),
                        Text(
                          "(${_formatDate(currentDate)})",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                        if (isPartiallyBooked) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: Colors.orange, width: 1),
                            ),
                            child: Text(
                              "Partial",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange[700],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 5),
                    dropdown(index, currentDate),
                    const SizedBox(height: 15),
                  ],
                );
              }),
              textfield(),
              const SizedBox(height: 20),

              // Continue Button
              _buildContinueButton(context, screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget dates(String dateText, double width) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          dateText,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget text(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget dropdown(int dayIndex, DateTime date) {
    List<String> availableOptions = _getAvailableOptions(date);
    String currentValue = selectedTimeSlots[dayIndex] ?? availableOptions.first;

    // Ensure the current value is in available options
    if (!availableOptions.contains(currentValue)) {
      currentValue = availableOptions.first;
      selectedTimeSlots[dayIndex] = currentValue;
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            items: availableOptions.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTimeSlots[dayIndex] = newValue;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(
      BuildContext context, double screenWidth, double screenHeight) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          // Handle booking confirmation
          _handleBookingConfirmation();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Confirm Booking",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleBookingConfirmation() {
    // Create booking summary
    Map<String, dynamic> bookingDetails = {
      'startDate': widget.startDate,
      'endDate': widget.endDate,
      'timeSlots': {},
    };

    for (int i = 0; i < dateRange.length; i++) {
      String dateKey = _formatDate(dateRange[i]);
      bookingDetails['timeSlots'][dateKey] = selectedTimeSlots[i];
    }

    // Print booking details for debugging
    print('Booking Details: $bookingDetails');

    // Show confirmation dialog or navigate to next screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Booking Confirmation',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Date Range: ${_formatDate(widget.startDate)} to ${_formatDate(widget.endDate)}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  'Time Slots:',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                ...List.generate(dateRange.length, (index) {
                  return Text(
                    'Day ${index + 1} (${_formatDate(dateRange[index])}): ${selectedTimeSlots[index]}',
                    style: GoogleFonts.poppins(fontSize: 12),
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle final booking submission
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Booking confirmed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Widget textfield() {
    return Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: const TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Your Name"),
          )),
    );
  }
}
