import 'package:common_user/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class eventcard extends StatefulWidget {
  const eventcard({super.key});

  @override
  State<eventcard> createState() => _eventcardState();
}

class _eventcardState extends State<eventcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
                   Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow:const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black38,
              ),
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0,),
                          Text("Vini Birthday Party", style:GoogleFonts.sahitya(color: AppColors.buttoncolor, fontSize: 19.0,fontWeight: FontWeight.bold)),
                          SizedBox(height: 4.0,),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                             // color: const Color.fromARGB(255, 235, 228, 228),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("Wedding",
                                style: TextStyle(  fontWeight: FontWeight.w700,
                                  color: Colors.black87,)),
                          ),
                        ],
                      ),
                        Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.hourglass_bottom, size: 18, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            "6d 13h 32m 42s",
                            style:TextStyle(color: Colors.white, fontWeight: FontWeight.w800,fontSize: 13.0),
                          ),
                        ],
                      ),
                    ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(height: 1.0,width: double.infinity,color: Colors.black54,),
              ),
              //idhoda code mudinji
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Checklist
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 20),
                  SizedBox(width: 4),
                  Text(
                    "Checklist",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width *0.4,
                  child: const LinearProgressIndicator(
                    value: 0.25, // 25%
                    backgroundColor: Color(0xFFE9EEF2),
                    valueColor: AlwaysStoppedAnimation(Color(0xFF2E7D32)),
                  ),
                ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                "25% completed",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                
                      // RIGHT: (placeholder for Budget or anything else)
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Expanded(
                          child: Column(
                            children: [
                            SizedBox(height: 15.0,),
                              Row(
                                  children: [
                                       const Icon(Icons.account_balance_wallet, color: Color(0xFF0EA5E9),size: 20.0,),SizedBox(width: 3.0,),
                                        Text("Budget", style:GoogleFonts.mPlus1(color: Colors.black87, fontSize: 16.0,fontWeight: FontWeight.bold)),
                                      ],
                              ),
                              Text("\$100 / \$100",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: AppColors.buttoncolor),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
              SizedBox(height: 14.0,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 14.0),
                child: Container(
                  child:const Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people,size: 20.0,color: Colors.deepPurple,), SizedBox(width: 4.0,),
                           Text("Invited Guest : ",style:TextStyle(fontSize:14.0,color: Colors.black45,fontWeight: FontWeight.bold ) ,),SizedBox(width: 4.0,),
                            Text("100 / 300",style:TextStyle(fontSize:15.0,color: Colors.black87,fontWeight: FontWeight.w900 ) ,),
                          //  Text(" / 300",style:TextStyle(fontSize:12.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                        ]
                        ),
                        SizedBox(height: 8.0,),
                         Row(
                        children: [
                          Icon(Icons.calendar_month_rounded,size: 20.0,color: Colors.deepPurple,), SizedBox(width: 4.0,),
                           Text("Date : ",style:TextStyle(fontSize:14.0,color: Colors.black45,fontWeight: FontWeight.bold ) ,),SizedBox(width: 4.0,),
                            Text("30/06/2025 - 31/06/2025",style:TextStyle(fontSize:15.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                          //  Text(" / 300",style:TextStyle(fontSize:12.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                        ]
                        ),
                        SizedBox(height: 8.0,),
                         Row(
                        children: [
                          Icon(Icons.place,size: 20.0,color: Colors.red,), SizedBox(width: 4.0,),
                           Text("Place : ",style:TextStyle(fontSize:14.0,color: Colors.black45,fontWeight: FontWeight.bold ) ,),SizedBox(width: 4.0,),
                            Text("Sivakasi SSK Mahal",style:TextStyle(fontSize:15.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                          //  Text(" / 300",style:TextStyle(fontSize:12.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                        ]
                        ),
                        SizedBox(height: 8.0,),
                         Row(
                        children: [
                          Icon(Icons.dry_cleaning_sharp,size: 20.0,color: Colors.orange,), SizedBox(width: 4.0,),
                           Text("Guests : ",style:TextStyle(fontSize:14.0,color: Colors.black45,fontWeight: FontWeight.bold ) ,),SizedBox(width: 4.0,),
                            Text("100 / 300",style:TextStyle(fontSize:15.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                          //  Text(" / 300",style:TextStyle(fontSize:12.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                        ]
                        ),
                        SizedBox(height: 8.0,),
                         Row(
                        children: [
                          Icon(Icons.people,size: 20.0,color: Colors.tealAccent,), SizedBox(width: 4.0,),
                           Text("Features Added : ",style:TextStyle(fontSize:14.0,color: Colors.black45,fontWeight: FontWeight.bold ) ,),SizedBox(width: 4.0,),
                           // Text("-",style:TextStyle(fontSize:15.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                            SizedBox(width: 5.0,),
                            Icon(Icons.card_giftcard_sharp,size: 17.0,color: Color(0xFF9A2143),),
                            SizedBox(width: 5.0,),
                            Icon(Icons.photo_camera,size: 17.0,color: Color(0xFF9A2143),),
                            SizedBox(width: 5.0,),
                            Icon(Icons.insert_invitation,size: 17.0,color: Color(0xFF9A2143),),
                            SizedBox(width: 5.0,),
                            Icon(Icons.video_chat,size: 17.0,color: Color(0xFF9A2143),),
                          //  Text(" / 300",style:TextStyle(fontSize:12.0,color: Colors.black87,fontWeight: FontWeight.bold ) ,),
                        ]
                        ),
                        SizedBox(height: 10.0,),
                     ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(height: 1.0,width: double.infinity,color: Colors.black54,),
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ const
        
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Row(
           // mainAxisAlignment: MainAxisAlignment.start,
            children: [
        Icon(Icons.person_add_alt_sharp,size: 20.0,color: Colors.blueAccent,),
        SizedBox(width: 6,),
        Text(
          'Co-Hosts = 0',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2E3B4E), // Dark slate gray
            letterSpacing: 0.35,
          ),
        ),
            ],
          ),
        ),
        
        
        Row(
                      mainAxisAlignment: MainAxisAlignment.end, // center align
                      children: [
                        // View
                        _circleIcon(
                          icon: Icons.remove_red_eye,
                          iconColor: Colors.grey,
                          onTap: () {
                // TODO: Handle View action
                          },
                        ),
                        const SizedBox(width: 16),
                
                        // Edit
                        _circleIcon(
                          icon: Icons.edit,
                          iconColor: Colors.red.shade700,
                          onTap: () {
                // TODO: Handle Edit action
                          },
                        ),
                        const SizedBox(width: 16),
                
                        // Delete
                        _circleIcon(
                          icon: Icons.delete,
                          iconColor: Colors.red,
                          onTap: () {
                // TODO: Handle Delete action
                          },
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              )
              //
              //
            ],
          ),
        ),
        ],
      ),
    );
  }
   Widget _circleIcon({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        child: Icon(icon, color: iconColor, size: 22.0),
      ),
    );
  }
}