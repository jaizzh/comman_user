import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/1st%20screen/eventplan.dart';
import 'package:common_user/homepage/New%20Event/3rd%20screen/maineventpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class eventformpage extends StatefulWidget {
  final String eventname1;
  final String eventcategory1;
  final String startdate1;
  final String enddate1;
  final int? eventdays;
  const eventformpage({super.key,required this.eventname1,required this.eventcategory1,required this.startdate1,required this.enddate1, required this.eventdays,});


  @override
  State<eventformpage> createState() => _eventformpageState();
}

class _eventformpageState extends State<eventformpage> {

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
             onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const eventplan()),
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Event Schedule",
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
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              eventImage(),
              SizedBox(height: 10.0,),
              about(),
              SizedBox(height: 10.0,),
              PreviewEvent(),
            ],
          ),
        )
      ),
    ),
    );
  }

  Widget about(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.boxlightcolor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.event_note_rounded, size: 20, color: Colors.black87),
                ),
                const SizedBox(width: 10),
                Text(
                  "About Events",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.buttoncolor,
                    letterSpacing: .2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Add a new event to your daily schedule. Fill in the details below to add it to your calendar.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                height: 1.45,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827).withOpacity(.74),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget eventImage() {
  final size = MediaQuery.of(context).size;
  final double totalH = size.height * 0.35;   

  return Container(
    // seamless canvas that continues after the image
    color: Colors.white,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // --- Banner ---
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: totalH,
            width: double.infinity,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                // Background image
                Image.asset(
                  "assets/images/trhg.png",
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
        Positioned(child: Container(
          child: 
              Padding(
                padding: const EdgeInsets.all(12.0),
                child:Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      "Create",
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: .5,
        color: const Color(0xFF9A2143), // premium accent
      ),
    ),
    const SizedBox(width: 12),
    Text(
      "•",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600,
      ),
    ),
    const SizedBox(width: 12),
    Text(
      "Invite",
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: .5,
        color: Colors.deepPurple,
      ),
    ),
    const SizedBox(width: 12),
    Text(
      "•",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600,
      ),
    ),
    const SizedBox(width: 12),
    Text(
      "Celebrate",
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: .5,
        color: Colors.orangeAccent,
      ),
    ),
  ],
)
),)),
    ],
    ),
  );
}
  Widget PreviewEvent(){
     return Stack(
        children: [
          Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header image
        
              // Accent divider
              Container(
                height: 2,
                width: double.infinity,
                color: AppColors.buttoncolor,
              ),

              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height *0.05,),
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.eventname1,
                          overflow: widget.eventname1.length >= 20 ? TextOverflow.ellipsis : TextOverflow.visible,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.buttoncolor,
                          ),
                        ),
                      ],
                    ), // Dates
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today_rounded,
                            size: 16, color: Colors.black45),
                        const SizedBox(width: 6),
                        Text(
                          widget.startdate1,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text("—",
                            style: TextStyle(
                                fontSize: 18, color: Colors.black45)),
                        const SizedBox(width: 8),
                        Text(
                         widget.enddate1,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
        
                    // center-la show panna:
Center(
  child: _metaPill(
    daysText: "No. of days =${widget.eventdays}",
    eventType: widget.eventcategory1,
  ),
),
const SizedBox(height: 12),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(
      Icons.workspace_premium_rounded,
      size: 24,
      color: AppColors.buttoncolor, // Use your gold/premium color
    ),
    const SizedBox(width: 6),
    Text(
      "Buy Event To Unlock More Features",
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.buttoncolor, // masked by ShaderMask
        shadows: [
          Shadow(blurRadius: 8, offset: Offset(0, 2), color: Colors.black26),
        ],
      ),
    ),
    //const SizedBox(width: 10),
    Icon(
      Icons.chevron_right_rounded,
      size: 22,
      color: AppColors.buttoncolor,
    ),
  ],
),

const SizedBox(height: 12),
        
_freePlanBanner(),
const SizedBox(height: 12),
Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "₹1,299",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.buttoncolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                           Navigator.push(context,MaterialPageRoute(builder: (_)=> demopage() ));
                          },
                          icon: const Icon(Icons.lock_outline_rounded,
                              size: 18, color: Colors.white),
                          label: Text(
                            "Buy Event",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttoncolor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
                            Positioned(
            top: -35,
            left: 0,
           right: 0,
            child: Container(
      height: MediaQuery.of(context).size.height *0.35,
      width: MediaQuery.of(context).size.width *0.02,
            decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage("assets/images/pnges.png"))
            ),
          )),
        ],
    );
    }
    
  Widget _freePlanBanner() {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.boxlightcolor,
            AppColors.boxboxlight,
            //AppColors.boxboxlight.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.boxdarkcolor.withOpacity(.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxdarkcolor.withOpacity(.15),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // icon badge
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.boxdarkcolor.withOpacity(.6),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              size: 22,
              color: AppColors.buttoncolor,
            ),
          ),
          const SizedBox(width: 12),

          // text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Premium Plan",
                  style: GoogleFonts.inter(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.buttoncolor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Start Your event with Free Plan",
                 // "Best for getting started — basic features",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),

          // price pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.95),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.boxdarkcolor.withOpacity(.6),
                width: 1,
              ),
            ),
            child: Text(
              "₹1,299",
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.w900,
                color: AppColors.buttoncolor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaPill({
  required String daysText,
  required String eventType,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4,),
    child: Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // left: days
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timelapse_rounded, size: 16, color: Color(0xFF9A2143) ),
                const SizedBox(width: 6),
                Text(
                  daysText,
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
              ],
            ),

            // divider
            Container(
              height: 20,
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: AppColors.boxdarkcolor.withOpacity(.6),
            ),

            // right: event type
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.celebration_rounded, size: 16, color: AppColors.buttoncolor),
                const SizedBox(width: 6),
                Text(
                  eventType,
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color:  const Color(0xFF111827), // wine accent
                    letterSpacing: .2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}


  // optional mini plan box (reusable)
  Widget plancont() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.boxlightcolor,
            AppColors.boxboxlight,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}




 