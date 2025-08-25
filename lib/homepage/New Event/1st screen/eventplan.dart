import 'dart:ui';
import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New Event/1st screen/eventlist.dart';
import 'package:common_user/homepage/New%20Event/2nd%20screen/eventformpage.dart';
import 'package:common_user/homepage/dashboard page/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class eventplan extends StatefulWidget {
  const eventplan({super.key});

  @override
  State<eventplan> createState() => _eventplanState();
}

class _eventplanState extends State<eventplan> {
 String selectedType = "Select one";
DateTime? startDate;
  DateTime? endDate;

  // Pretty strings
  static final DateFormat _df = DateFormat('dd-MM-yyyy');
  String get startPretty => (startDate == null) ? '' : _df.format(startDate!);
  String get endPretty   => (endDate == null) ? '' : _df.format(endDate!);

final TextEditingController eventnamecon = TextEditingController();
String get eventName2 => eventnamecon.text; // always up-to-date


  
  String? selectedPlan;
  static const double _fabHeight = 50;
static const double _fabBottomGap = 20; // distance from bottom
late int dayyy;

  // Inclusive days (e.g. 1–3 = 3)
  int? get diffDays {
    if (startDate == null || endDate == null) return null;
    dayyy = endDate!.difference(startDate!).inDays;
    return dayyy >= 0 ? dayyy + 1 : null; // inclusive
  }

  // Invalid if end before start OR > 11 days (inclusive rule)
  bool get isInvalidDateRange {
    if (startDate == null || endDate == null) return false;
    final d = endDate!.difference(startDate!).inDays;
    return d < 0 || d > 11;
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();

    final initial = isStart
        ? (startDate ?? now)
        : (endDate ?? startDate ?? now);

    final firstDateForPicker = isStart
        ? DateTime(now.year, now.month, now.day - 1)
        : (startDate != null
            ? startDate!
            : DateTime(now.year, now.month, now.day - 1));

    final last = DateTime(now.year + 5);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDateForPicker,
      lastDate: last,
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

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  String _fmt(DateTime? d) {
    if (d == null) return "";
    return "${d.day.toString().padLeft(2, '0')}-"
        "${d.month.toString().padLeft(2, '0')}-"
        "${d.year}";
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => homepage())),
        ),
      ),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Create Event",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),

    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
      16, 8, 16,
      _fabHeight + _fabBottomGap + 6, // ✅ reserve space for the floating button
    ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            label("Event Type"),
            const SizedBox(height: 10.0),
            dropdownField(),
            const SizedBox(height: 10.0),
             label("Event Name"),
             const SizedBox(height: 10.0),
             eventnameform1(hint: "Eventname", maxer: 30, specifyname: false, parteventname: eventnamecon, iutyu: Icon(Icons.event,color: Colors.black26,)),
             const SizedBox(height: 10.0),
            Row(
              children: [
                label("Date"),
                if (startDate != null && endDate != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    isInvalidDateRange ? "(Invalid date)" : "(Days = $diffDays)",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isInvalidDateRange ? Colors.red :  Color(0xFF16A34A),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: _dateField(
                    title: "Start Date",
                    value: _fmt(startDate),
                    onTap: () => _pickDate(isStart: true),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _dateField(
                    title: "End Date",
                    value: _fmt(endDate),
                    onTap: () => _pickDate(isStart: false),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            label("Plan"),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: PlanCard(plan: "Free Plan", amount: "\$0",  viewplan: "Current Plan")),
                const SizedBox(width: 12),
                Expanded(child: PlanCard(plan: "Basic Plan", amount: "\$10", viewplan: "View Plan")),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: PlanCard(plan: "Premium Plan", amount: "\$49", viewplan: "View Plan")),
                const SizedBox(width: 12),
                Expanded(child: PlanCard(plan: "Business Plan", amount: "\$99", viewplan: "View Plan")),
              ],
            ),
          ],
        ),
      ),
    ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
floatingActionButton: Builder(
  builder: (context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
      ),
      child: choosePlanButton(onPressed: () {
        // TODO: next action
      }),
    );
  },
),

  );
}

  // ---------- UI Helpers ----------

  Widget label(String text) => Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget dropdownField() {
  final bool showTick = selectedType != null && selectedType != "Select one";

  return Container(
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    height: 48,
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedType,
        isExpanded: true,
        dropdownColor: Colors.white,
        style: GoogleFonts.inter(
          color: Colors.black45,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        // arrow + (optional) tick on the RIGHT; arrow nudges left when tick shows
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
            if (showTick) ...[
              const SizedBox(width: 8),
              const Icon(Icons.check_circle_rounded, size: 20, color: Color(0xFF9A2143),),
            ],
          ],
        ),
        items: eventsLists
            .map(
              (eventtypename) => DropdownMenuItem<String>(
                value: eventtypename,
                child: Text(
                  eventtypename,
                  style: TextStyle(
                    color: eventtypename == "Select one" ? Colors.black38 : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => selectedType = value!),
      ),
    ),
  );
}


Widget eventnameform1({
  required String hint,
  required int maxer,
  required bool specifyname, // kept for signature; not needed for state
  required TextEditingController parteventname,
  required Widget iutyu,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // derive validity from controller text so it survives parent rebuilds
      final bool isOk = parteventname.text.trim().length >= 3;

      return Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1),
          ],
        ),
        child: TextFormField(
          controller: parteventname,
          maxLength: maxer,
          onChanged: (_) => setState(() {}), // rebuild to refresh suffix icon
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            // no borders from the field; only wrapper shows styling
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            prefixIcon: iutyu,
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isOk
                  ? const Icon(Icons.check_circle_rounded,
                      key: ValueKey('ok'), color:  Color(0xFF9A2143), size: 20)
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ),
      );
    },
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
        height: 48,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black38,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
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
            const Icon(Icons.calendar_today_rounded, size: 18, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget PlanCard({
    required String plan,
    required String amount,
    required String viewplan,
  }) {
    final bool selected = selectedPlan == plan;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          selectedPlan = selected ? null : plan; // proper toggle
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.buttoncolor : const Color(0xFFE3E8EF),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(selected ? 0.12 : 0.06),
              blurRadius: selected ? 18 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              plan,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),

            // Amount / month
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.buttoncolor,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    '/month',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4B5563),
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Pill
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                viewplan,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 14),
            checkRow(text: "invite people = 100", iconss: Icons.verified_rounded, kalaru: Colors.greenAccent),
            checkRow(text: "No Gift Registry", iconss: Icons.verified_rounded, kalaru: Colors.greenAccent),
            checkRow(text: "No Co-hosts", iconss: Icons.close, kalaru: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget checkRow({required String text,required IconData iconss,required Color kalaru}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconss,
            size: 16,
            color:kalaru,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }
 Widget choosePlanButton({VoidCallback? onPressed}) {
  final bool isEnabled =
      selectedPlan != null || startDate != null || endDate != null || !isInvalidDateRange; // from your state

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap:(){
          if(isEnabled == true){
           Navigator.push(context, MaterialPageRoute(builder: (_)=> eventformpage(eventname1: eventName2, eventcategory1: selectedType, startdate1: startPretty, enddate1: endPretty, eventdays: diffDays,)));
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text("Fill all the form first")),
);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: 50,
          width: 175, // full width in a Column
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.buttoncolor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isEnabled ? AppColors.buttoncolor : const Color(0xFFE5E7EB),
              width: isEnabled ? 2 : 1,
            ),
            boxShadow: [
              if (isEnabled)
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              if (!isEnabled)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Continue",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isEnabled ? Colors.white : Colors.black54,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: isEnabled ? Colors.white : Colors.black54,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}


}
