import 'package:common_user/common/razorpay/razorpay.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:common_user/common/colors.dart';
// import 'package:common_user/homepage/dashboard page/homepage.dart'; // if you navigate there

Future<void> showEventScheduleDialog(
  BuildContext context, {
  required String eventName,
  required String eventCategory,
  required String startDate,
  required String endDate,
  required int? eventDays, 
  }) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
     // final size = MediaQuery.of(ctx).size;
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white, // M3 gloss (optional)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: MediaQuery.of(context).size.height * 0.370,
          width: MediaQuery.of(context).size.width * 1.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.white,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // ------- Header -------
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.boxlightcolor, AppColors.boxboxlight],
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.boxdarkcolor.withOpacity(.35),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(Icons.event_rounded, size: 22, color: Colors.black87),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Event Schedule',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Close',
                            onPressed: () => Navigator.pop(ctx),
                            icon: const Icon(Icons.close_rounded,size: 18.0,),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ------- Body (scrollable) -------
                  Container(
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(height: 10.0,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  eventName,
                                  overflow: eventName.length >= 20
                                      ? TextOverflow.ellipsis
                                      : TextOverflow.visible,
                                  style: GoogleFonts.inter(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.buttoncolor,
                                  ),
                                ),
                            ),
                              Row(
                              children: [
                                const Icon(Icons.calendar_today_rounded,
                                    size: 14, color: Colors.black45),
                                const SizedBox(width: 6),
                                Text(
                                  startDate,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text('—', style: TextStyle(fontSize: 15, color: Colors.black45)),
                                const SizedBox(width: 4),
                                Text(
                                  endDate,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                              _MetaPill(
                            daysText: "No. of days = $eventDays",
                            eventType: eventCategory,
                          ),
                          
                          ],
                        ),
                         Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/shop.jpg"))
                        ),
                      )
                            
                      ],
                    ),
                  ), // idhoda image varaiki mudinchi

                          // Promo row
                          SizedBox(height: 10.0,),
                         
                         // const SizedBox(height: 14),

                          // Free/Premium banner
                          _FreePlanBanner(),

                         const SizedBox(height: 10),
                         Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.workspace_premium_rounded,
                                  size: 18, color: AppColors.buttoncolor),
                              const SizedBox(width: 4),
                              Text(
                                "Buy Event To Unlock More Features",
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.buttoncolor,
                                  shadows: const [
                                    Shadow(blurRadius: 8, offset: Offset(0, 2), color: Colors.black26),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.chevron_right_rounded,
                                  size: 22, color: AppColors.buttoncolor),
                            ],
                          ),

                          SizedBox(height: 8.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Total",
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "₹1,299",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.buttoncolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton.icon(
                                onPressed: () {
  // 1) Close the dialog first
  Navigator.of(ctx).pop();

  // 2) Open Razorpay on next frame to avoid overlay conflicts
  WidgetsBinding.instance.addPostFrameCallback((_) {
    RazorpayService.instance.openCheckout(
      keyId: "rzp_test_1DP5mmOlF5G5ag", // "rzp_test_qnICfDxMOIbOaI",
      amountPaise: 1000, context: context, // ₹1,299 = 129900 paise
      // orderId: 'order_xxx', // only if created with SAME TEST key on server
    );
  });
},
                                  icon: const Icon(Icons.lock_outline_rounded, size: 18, color: Colors.white),
                                  label: Text(
                                    "Buy Event",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.buttoncolor,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// --- Pieces reused from your page ---

class _MetaPill extends StatelessWidget {
  final String daysText;
  final String eventType;
  const _MetaPill({required this.daysText, required this.eventType});

  @override
  Widget build(BuildContext context) {
    return Container(
    //  padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timelapse_rounded, size: 13, color: Color(0xFF9A2143)),
              const SizedBox(width: 4),
              Text(
                daysText,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),
          Container(
            height: 20,
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal:4),
            color: AppColors.boxdarkcolor.withOpacity(.6),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.celebration_rounded, size: 13, color: AppColors.buttoncolor),
              const SizedBox(width: 4),
              Text(
                eventType,
                 style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FreePlanBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.boxlightcolor, AppColors.boxboxlight],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.boxdarkcolor.withOpacity(.6), width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.boxdarkcolor.withOpacity(.15),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.9),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.boxdarkcolor.withOpacity(.6), width: 2),
                ),
                child: Icon(Icons.emoji_events_rounded, size: 20, color: AppColors.buttoncolor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Premium Plan",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.buttoncolor,
                        )),
                    Text("Start Your event with Free Plan",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827),
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.95),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.boxdarkcolor.withOpacity(.6), width: 2),
                ),
                child: Text("₹1,299",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttoncolor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



 