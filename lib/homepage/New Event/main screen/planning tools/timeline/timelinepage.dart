import 'package:common_user/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class timeline extends StatefulWidget {
  const timeline({super.key});

  @override
  State<timeline> createState() => _timelineState();
}

class _timelineState extends State<timeline> {
  // Controllers
  final TextEditingController eventnamecont = TextEditingController();
  final TextEditingController placenamecont = TextEditingController();

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Saved timelines (max 6)
  final List<Map<String, String>> fields = [];

  // Date & time
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Validity flags from text fields
  bool _isEventNameValid = false;
  bool _isPlaceValid = false;

  // ---------- Helpers ----------
  String _fmtTime(TimeOfDay? t, {bool twelveHour = true}) {
    if (t == null) return "";
    final minute = t.minute.toString().padLeft(2, '0');
    if (twelveHour) {
      final hour12 = t.hourOfPeriod.toString().padLeft(2, '0');
      final ampm = t.period == DayPeriod.am ? 'AM' : 'PM';
      return "$hour12:$minute $ampm";
    }
    final hour24 = t.hour.toString().padLeft(2, '0');
    return "$hour24:$minute";
  }

  String _fmt(DateTime? d) {
    if (d == null) return "";
    return "${d.day.toString().padLeft(2, '0')}-"
        "${d.month.toString().padLeft(2, '0')}-"
        "${d.year}";
  }

  int _toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  bool get _areTimesValid {
    if (startTime == null || endTime == null) return false;
    return _toMinutes(endTime!) >= _toMinutes(startTime!); // end >= start
  }

  // form filled + time valid
  bool get _canSaveOne =>
    _isEventNameValid &&
      _isPlaceValid &&
      selectedDate != null &&
      startTime != null &&
      endTime != null &&
      _areTimesValid;


  bool get _canSave => _canSaveOne;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year, now.month, now.day - 1),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3DA9FC),
              onPrimary: Colors.white,
              surface: Color(0xFF122030),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF0F1C27),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _pickTime({required bool isStart}) async {
    final now = TimeOfDay.now();
    final initial = isStart ? (startTime ?? now) : (endTime ?? startTime ?? now);

    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3DA9FC),
              onPrimary: Colors.white,
              surface: Color(0xFF122030),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF0F1C27),
            timePickerTheme: const TimePickerThemeData(
              dialBackgroundColor: Color(0xFF122030),
              hourMinuteTextColor: Colors.white,
              dayPeriodTextColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    setState(() {
      if (isStart) {
        startTime = picked;
        if (endTime != null && !_areTimesValid) {
          endTime = null; // clear invalid end
        }
      } else {
        if (startTime != null && _toMinutes(picked) < _toMinutes(startTime!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("End time can't be before start time")),
          );
          return;
        }
        endTime = picked;
      }
    });
  }

  // ---------- Save current as Map and push to list ----------
  void _saveCurrentTimeline() {
    if (!_canSaveOne) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill the form correctly")),
      );
      return;
    }

    final data = <String, String>{
      'eventName': eventnamecont.text.trim(),
      'place': placenamecont.text.trim(),
      'date': _fmt(selectedDate),
      'start': _fmtTime(startTime),
      'end': _fmtTime(endTime),
      // 6th string value – a unique id (or you can store "index: ${fields.length+1}")
      'id': DateTime.now().microsecondsSinceEpoch.toString(),
    };

    setState(() {
      fields.add(data);
    });

    // Clear inputs for next entry
   _clearInputsOnly();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Your TimeLine Was Added Successfully",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),)),
    );
  }

  void _clearInputsOnly() {
    setState(() {
      startTime = null;
      endTime = null;
      selectedDate = null;
      eventnamecont.clear();
      placenamecont.clear();
      _isEventNameValid = false;
      _isPlaceValid = false;
    });
  }

  void _removeAt(int index) {
    setState(() => fields.removeAt(index));
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Form(
            key: _formKey,
            child:Stack(
              children: [
                Container(
                child: Column(
                   children: [
                  const SizedBox(height: 12),
                  timelineadd(),
                  const SizedBox(height: 12),
                  _savedList(),
                ],
                ),
              ),
              ], 
            ),
          ),
        ),
      ),
    );
  }

  Widget labell(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                color: AppColors.buttoncolor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

  Widget kuttylabel(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

  Widget timelineadd() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        // better to avoid fixed height if list grows; keep your design if needed
        // height: MediaQuery.of(context).size.height * 0.510,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 14),
              labell("Add Your Timelines"),
                  const SizedBox(height: 10),
   //         kuttylabel("Event Name"),
  //          const SizedBox(height: 6),
            _textBox(
              hint: "Event name",
              maxLen: 28,
              controller: eventnamecont,
              icon: const Icon(Icons.label_important, color: Colors.black45),
              onValidChanged: (ok) {
                if (_isEventNameValid != ok) {
                  setState(() => _isEventNameValid = ok);
                }
              },
            ),
            const SizedBox(height: 10),
    //        kuttylabel("Date"),
    //        const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _dateField(
                title: "Choose Date",
                value: _fmt(selectedDate),
                onTap: _pickDate,
              ),
            ),
            const SizedBox(height: 10),
    //        kuttylabel("Choose Timing"),
    //        const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: _dateField(
                      title: "Start Time",
                      value: _fmtTime(startTime),
                      onTap: () => _pickTime(isStart: true),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _dateField(
                      title: "End Time",
                      value: _fmtTime(endTime),
                      onTap: () => _pickTime(isStart: false),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
    //        kuttylabel("Place"),
    //       const SizedBox(height: 6),
            _textBox(
              hint: "Place",
              maxLen: 35,
              controller: placenamecont,
              icon: const Icon(Icons.place, color: Colors.black45),
              onValidChanged: (ok) {
                if (_isPlaceValid != ok) {
                  setState(() => _isPlaceValid = ok);
                }
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                clearbutton(),
                savebutton(),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Reusable styled TextFormField with validator and callback
  Widget _textBox({
    required String hint,
    required int maxLen,
    required TextEditingController controller,
    required Widget icon,
    required Function(bool) onValidChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 42.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1),
          ],
        ),
        child: TextFormField(
          controller: controller,
          maxLength: maxLen,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (v) {
            final ok = v.trim().length >= 1;
            onValidChanged(ok);
          },
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: Colors.black45,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: icon,
          ),
        ),
      ),
    );
  }

  Widget _dateField({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 42.5,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.access_time_filled, size: 18, color: Colors.black45),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                value.isEmpty ? title : value,
                style: GoogleFonts.inter(
                  color: value.isEmpty ? Colors.black45 : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Save adds current form as Map<String,String> to `fields`
  Widget savebutton() {
    final isEnabled = _canSave;

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: isEnabled
                ? _saveCurrentTimeline
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Fill All The Fields")),
                    );
                  },
            child: Opacity(
              opacity: isEnabled ? 1.0 : 0.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.buttoncolor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget clearbutton() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: _clearInputsOnly,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black26,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: const Text(
                "Clear",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Saved items list (preview + delete)
  Widget _savedList() {
    if (fields.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Saved Timelines: ${fields.length}",
                style: GoogleFonts.inter(
                  color: AppColors.buttoncolor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: fields.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final m = fields[i];
               return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1),
      ],
    ),
    child: Stack(
      children: [
        // accent bar
        Positioned.fill(
          left: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 4,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.buttoncolor, // your brand color
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
          child: Row(
            children: [
              const SizedBox(width: 8),
              // main info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title + date pill
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                           m['eventName']!  ,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.boxboxlight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.event, size: 14, color: Colors.black54),
                              const SizedBox(width: 6),
                              Text(
                                m['date']! ,
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

                    const SizedBox(height: 8),

                    // time row
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: Colors.black54),
                        const SizedBox(width: 6),
                        Text(
                         "${ m['start']!}   –  ${m['end']!} ",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // place row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.place, size: 16, color: Colors.black54),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            m["place"]!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // delete button
              IconButton(
                tooltip: 'Delete',
                onPressed: (){
                  _removeAt(i);
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    ),
  );
            },
          ),
        ],
      ),
    );
  }
}
