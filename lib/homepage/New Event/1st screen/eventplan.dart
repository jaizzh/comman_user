import 'package:common_user/common/colors.dart';
import 'package:common_user/common/razorpay/razorbool.dart';
import 'package:common_user/homepage/New Event/1st screen/eventlist.dart';
import 'package:common_user/homepage/New%20Event/1st%20screen/alertscreen.dart';
import 'package:common_user/homepage/New%20Event/2nd%20screen/eventformpage.dart';
import 'package:common_user/homepage/dashboard page/homepage.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
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
final TextEditingController mobilecont = TextEditingController();
String get mobilename => mobilecont.text; 

final TextEditingController subform1con = TextEditingController();
String get subform11 => subform1con.text;
final TextEditingController subform2con = TextEditingController();
String get subform22 => subform2con.text;
final TextEditingController subform3con = TextEditingController();
String get subform33 => subform3con.text;


  
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
      surfaceTintColor: AppColors.boxlightcolor,
      toolbarHeight: MediaQuery.of(context).size.height * 0.06,
      backgroundColor: AppColors.boxlightcolor,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,size: 18.0,),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => homepage())),
        ),
      ),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Create Event",
           style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: Colors.black,
          ),
        ),
      ),
    ),

    body: SafeArea(
      child: SingleChildScrollView(
   
        child: Stack(
          children: [
                      Positioned(child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                AppColors.boxlightcolor,
                Colors.white,
              ])
            ),
          )),
             Container(
                 padding: EdgeInsets.fromLTRB(
       12, 8, 12,
       _fabHeight + _fabBottomGap + 6, // ✅ reserve space for the floating button
     ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0,),
                label("Event Type"),
                const SizedBox(height:4.0),
                dropdownField(),
                const SizedBox(height: 6.0),
                 label("Event Name"),
                 const SizedBox(height: 4.0),
                 eventnameform1(hint: "Eventname", maxer: 30, specifyname: false, parteventname: eventnamecon),
                 const SizedBox(height: 6.0),
                Row(
                  children: [
                    label("Date"),
                    if (startDate != null && endDate != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        isInvalidDateRange ? "(Invalid date)" : "Days = $diffDays",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isInvalidDateRange ? Colors.red : AppColors.buttoncolor,
                        ),
                      ),
                    ],
                  ],
                ),
            
                const SizedBox(height: 4.0),
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
                const SizedBox(height: 6),
                label("Mobile No"),
                const SizedBox(height: 6),
                mobileform(hint: "Mobile No", maxer: 10, specifyname: false, parteventname: mobilecont),
                if(selectedType != "Select one") additionalfield(),

              ],
            ),
          ),
          ],
        
        ),
      ),
    ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
floatingActionButton: Builder(
  builder: (context) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
        ),
        child: choosePlanButton(onPressed: () {
          // TODO: next action
        }),
      ),
    );
  },
),

  );
}


Widget additionalfield(){
  return Container(
    child: Container(
      decoration: BoxDecoration(

      ),
      child: Column(
        children: [
            SizedBox(height: 20.0), 
            
               Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Additional Details",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: AppColors.buttoncolor),),
                    ],
                  ),  
                 SizedBox(height: 8.0,), 
                  label("Organizer Name"), 
                   const SizedBox(height: 6.0,), 
                    subform1(hint: " ${selectedType} Organizer Name", maxer: 30, specifyname: false, parteventname: subform1con ),
                  SizedBox(height: 6.0,), 
                  label("Email Id"),
                   SizedBox(height: 6.0,), 
                   subform2(hint: "Email Id", maxer: 20, specifyname: false, parteventname: subform2con),
                 SizedBox(height: 6.0,),
                   label("${selectedType} Address"),
                   SizedBox(height: 6.0,),  
                  subform3(hint: "Address", maxer:100, specifyname: false, parteventname: subform3con),
        ],
      ),
    ),
  );
}

  Widget label(String text) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
    ],
  );

  Widget dropdownField() {
  final bool showTick =  selectedType != "Select one";

  return Container(
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38),
      ],
      color: Colors.white,
      border:Border.all(color: Colors.black26,width: 0.750) ,
     // border: showTick ? Border.all(color: Colors.black26,width: 0.750) : Border.all(color: AppColors.buttoncolor,width: 0.750),
      borderRadius: BorderRadius.circular(4.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    height: MediaQuery.of(context).size.height * 0.05,
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
              const Icon(Icons.check, size: 20, color:Colors.green),
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
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // derive validity from controller text so it survives parent rebuilds
      final bool isOk = parteventname.text.trim().length >= 3;

      return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
        border:Border.all(color: Colors.black26,width: 0.750) ,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1),
          ],
        ),
        child: TextFormField(
          controller: parteventname,
          maxLength: maxer,
          onChanged: (_) => setState(() {}), // rebuild to refresh suffix icon
          autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
          decoration: InputDecoration(
            // no borders from the field; only wrapper shows styling
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12.0),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14.0),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isOk
                  ?  const Icon(Icons.check, size: 20, color:Colors.green)
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ),
      );
    },
  );
}

Widget subform1({
  required String hint,
  required int maxer,
  required bool specifyname, // kept for signature; not needed for state
  required TextEditingController parteventname,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // derive validity from controller text so it survives parent rebuilds
      final bool isOk = parteventname.text.trim().length >= 3;

      return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border.all(color: Colors.black26,width: 0.750) ,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1),
          ],
        ),
        child: TextFormField(
          controller: parteventname,
          maxLength: maxer,
          onChanged: (_) => setState(() {}), // rebuild to refresh suffix icon
          autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
          decoration: InputDecoration(
            // no borders from the field; only wrapper shows styling
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12.0),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14.0),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isOk
                  ?  const Icon(Icons.check, size: 20, color:Colors.green)
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ),
      );
    },
  );
}

Widget subform2({
  required String hint,
  required int maxer,
  required bool specifyname, // kept for signature; not needed for state
  required TextEditingController parteventname,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // derive validity from controller text so it survives parent rebuilds
      final bool isOk = parteventname.text.trim().length >= 3;

      return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border.all(color: Colors.black26,width: 0.750) ,
           // border:  Border.all(color: AppColors.buttoncolor,width: 0.750),
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1),
          ],
        ),
        child: TextFormField(
          controller: parteventname,
          maxLength: maxer,
          onChanged: (_) => setState(() {}), // rebuild to refresh suffix icon
          autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
          decoration: InputDecoration(
            // no borders from the field; only wrapper shows styling
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12.0),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14.0),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isOk
                  ?  const Icon(Icons.check, size: 20, color:Colors.green)
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ),
      );
    },
  );
}

Widget subform3({
  required String hint,
  required int maxer,
  required bool specifyname, // kept for signature; not needed for state
  required TextEditingController parteventname,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // derive validity from controller text so it survives parent rebuilds
      final bool isOk = parteventname.text.trim().length >= 3;

      return Container(
      //  height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border.all(color: Colors.black26,width: 0.750) ,
           // border:  Border.all(color: AppColors.buttoncolor,width: 0.750),
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1),
          ],
        ),

        child: TextFormField(
           maxLines: 3, // makes it multi-line for address
          keyboardType: TextInputType.streetAddress,
          controller: parteventname,
          maxLength: maxer,
          onChanged: (_) => setState(() {}), // rebuild to refresh suffix icon
          autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
          decoration: InputDecoration(
            
            // no borders from the field; only wrapper shows styling
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12.0),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14.0),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isOk
                  ?  const Icon(Icons.check, size: 20, color:Colors.green)
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ),
      );
    },
  );
}


Widget mobileform({
  required String hint,
  required int maxer,
  required bool specifyname, // kept for signature; not needed for state
  required TextEditingController parteventname,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // derive validity from controller text so it survives parent rebuilds
      final bool isOkmobile = parteventname.text.trim().length == 10;

      return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          border:Border.all(color: Colors.black26,width: 0.750) ,
            //border:  Border.all(color: AppColors.buttoncolor,width: 0.750),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1),
          ],
        ),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: parteventname,
          maxLength: maxer,
          onChanged: (_) => setState(() {}), // rebuild to refresh suffix icon
          autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
          decoration: InputDecoration(
            // no borders from the field; only wrapper shows styling
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12.0),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14.0),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isOkmobile
                  ?  const Icon(Icons.check, size: 20, color:Colors.green)
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
       final bool isokstartdate = startDate != null;
        final bool isokenddate = endDate != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          border:Border.all(color: Colors.black26,width: 0.750) ,
            //border:  Border.all(color: AppColors.buttoncolor,width: 0.50),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black38,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value.isEmpty ? title : value,
                style: GoogleFonts.inter(
                  color: value.isEmpty ? Colors.black45 : Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.calendar_today_rounded, size: 18, color: Colors.black38),
            SizedBox(width: 10.0,),
            if(isokstartdate && isokenddate)  const Icon(Icons.check, size: 20, color:Colors.green),
           // if(isokenddate)  const Icon(Icons.check_circle, size: 20, color:Colors.greenAccent)
          ],
        ),
      ),
    );
  }

 Widget choosePlanButton({VoidCallback? onPressed}) {
  final bool isEnabled =
      selectedType != "Select one" && startDate != null && endDate != null && !isInvalidDateRange;// && mobilename.length == 10 && eventName2.length >= 3  && subform11.length >= 3  && subform22.length >= 3  && subform33.length >= 3;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap:(){
            if(isEnabled == true){
              EventScheduleDialog(
  context,
  eventName: eventName2,
  eventCategory: selectedType,
  startDate: startPretty,
  endDate: endPretty,
  eventDays: diffDays,
  mobile: mobilename,
  organizerName: subform11,
  email: subform22,
  address: subform33,
  onConfirm: () {
     EventGate.showEventSummary.value = true;
    Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPage()));
  },
);
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
            height: MediaQuery.of(context).size.height * 0.045,
            width: MediaQuery.of(context).size.width * 0.94, 
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isEnabled ? AppColors.buttoncolor : Colors.white,
              borderRadius: BorderRadius.circular(4),
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
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isEnabled ? Colors.white : Colors.black54,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: isEnabled ? Colors.white : Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}





//   Widget PlanCard({
//     required String plan,
//     required String amount,
//     required String viewplan,
//   }) {
//     final bool selected = selectedPlan == plan;

//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: () {
//         setState(() {
//           selectedPlan = selected ? null : plan; // proper toggle
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 220),
//         curve: Curves.easeOut,
//         padding: const EdgeInsets.symmetric(horizontal: 8.0,),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: selected ? AppColors.buttoncolor : const Color(0xFFE3E8EF),
//             width: selected ? 2 : 1,
//           ),
//           boxShadow: [
//             BoxShadow(
// blurRadius: 1,
// spreadRadius: 1,
// color: Colors.black26,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 6.0,),
//             Text(
//               plan,
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFF111827),
//               ),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   amount,
//                   style: GoogleFonts.inter(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                     color: AppColors.buttoncolor,
//                     height: 1.0,
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 2),
//                   child: Text(
//                     '/month',
//                     style: GoogleFonts.inter(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xFF4B5563),
//                       height: 1.0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),

//             Container(
//               width: double.infinity,
//               alignment: Alignment.center,
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.black12,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 viewplan,
//                 style: GoogleFonts.inter(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             checkRow(text: "Invite Guest", iconss: Text("100",style: TextStyle(fontSize: 12.0,color: Colors.black54,fontWeight: FontWeight.bold))),
//             SizedBox(height: 2.0,),
//             checkRow(text: "Gift Registry", iconss:Icon(Icons.verified_rounded,color: Colors.greenAccent,size: 15.0,),),
//             SizedBox(height: 2.0,),
//             checkRow(text: "No Co-hosts", iconss: Icon(Icons.close,color: Colors.red,size: 15.0),),
//             SizedBox(height: 2.0,),
//              checkRow(text: "Budget Report", iconss: Icon(Icons.close,color: Colors.red,size: 15.0)),
//              SizedBox(height: 2.0,),
//               checkRow(text: "Planning Tools", iconss: Icon(Icons.close,color: Colors.red,size: 15.0)),
//               SizedBox(height: 2.0,),
//                checkRow(text: "Money Gift", iconss: Icon(Icons.close,color: Colors.red,size: 15.0)),
//                  SizedBox(height: 8.0,),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget checkRow({required String text,required Widget iconss}) {
//     return  Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               text,
//               style: GoogleFonts.inter(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color:Colors.black87,
//               ),
//             ),
//           ),
//            iconss,
//         ],
//       );
//   }