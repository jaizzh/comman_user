import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class singledashhalf extends StatefulWidget {
  const singledashhalf({super.key});

  @override
  State<singledashhalf> createState() => _singledashhalfState();
}

class _singledashhalfState extends State<singledashhalf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          firstcont(),
        ],
      ),
    );
  }
  

Widget firstcont(){
  return Stack(
    children: [
      Container(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height *0.370,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.boxlightcolor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(200, 100),bottomRight: Radius.elliptical(200, 100))
                ),
  child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
   SizedBox(height:20.0,),
   Padding(
       padding: const EdgeInsets.symmetric(horizontal: 14.0),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
      Text("jegaz Birthday Party",style: GoogleFonts.yaldevi(fontSize: 14.0,fontWeight: FontWeight.bold,color: AppColors.buttoncolor),),
       SizedBox(height: 2.0,),
       Row(
             children: [
        Text("Night Party",style: TextStyle(fontSize: 11.0,color: Colors.black54,fontWeight: FontWeight.bold)),
        SizedBox(width: 4.0,),
        Container(height: 10.0,width: 1.0,color: Colors.black54),
         SizedBox(width: 4.0,),
       Row(
        children: [
          Icon(Icons.location_on,color: Colors.black54,size: 12.0,),
          Text("Madhurai",style: TextStyle(fontSize: 11.0,color: Colors.black54,fontWeight: FontWeight.bold),)
        ],
       ) 
             ],
       ),
          ],
        ),
        //PremiumCountdownContainer(initialDuration: )
     ],),
   ),
   SizedBox(height: 4.0,),
   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child:Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0)
      ),
      child: Text("Choose Plan ",style: GoogleFonts.mukta(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.black)),
    ) 
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: PremiumCountdownContainer(initialDuration: Duration(days: 12, hours: 5, minutes: 32), ),
  )
    ],
   ),
   SizedBox(height: 16.0,),
   Padding(
     padding: const EdgeInsets.symmetric(horizontal: 12.0),
     child: Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("Events Completed",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black),),
               Text("3/14",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black),),
               ],
          ),
          SizedBox(height: 4.0,),
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8.0),
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: 0.3,
              valueColor:AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 10.0,
              stopIndicatorRadius: 20.0,
              stopIndicatorColor: Colors.black,
            ))
        ],
      ),
     ),
   ),
   SizedBox(height: 15.0,),
   Row(
    mainAxisAlignment: MainAxisAlignment.center ,
    children: [
         Text("Current Plan : Free Plan",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.black),),
    ],
   )
  

      ],
    ) 
      ),
         
      Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
          ],
        ),
      ),
       Positioned(
          bottom: -MediaQuery.of(context).size.height * 0.01 + MediaQuery.of(context).size.height * 0.03 ,
          right: 0,
          left: 0,
          
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             venuevendor(pathds:"assets/images/vendoror.png" , namevenue: "Venue", uptohow: "upto 100+ Venues", stars: '⭐⭐⭐⭐⭐', names: 'Venues', value: 0, no_of: '0/1', nameof: 'no.of venues'),
                   venuevendor(pathds: "assets/images/venueor.png", namevenue: "Vendors", uptohow: "upto 500+ Vendors", stars: '⭐⭐⭐⭐', names: 'Vendors', value: 0, no_of: '0/3', nameof: 'no.of vendors')
          ],
        )),
    ],
  );
}
Widget venuevendor({required String pathds,required String stars, required String namevenue,required double value,  required String uptohow,required String names ,required String no_of,required String nameof,}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: MediaQuery.of(context).size.height *0.225,
        width:  MediaQuery.of(context).size.width *0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black38,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 4.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(names,style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color:AppColors.buttoncolor),)
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
  height: 85, // full container height
  width: 85,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
      color: Colors.white,
    boxShadow: [
      BoxShadow(
        spreadRadius: 1,
        blurRadius: 1,
        color: Colors.black26
      )
    ]
  ),
  child: Center(
    child: Image.asset(
      pathds,
      height: 65,   
      width: 60,
    ),
  ),
),
SizedBox(height: 4.0,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(nameof,style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold,color: Colors.black) ,),
                    Text(no_of ,style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold,color: Colors.black) ,),
                  ],
                 ),
               ),
               SizedBox(height: 4.0,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(8),
                   child: LinearProgressIndicator(
                     value: value,
                     minHeight: 8,
                     backgroundColor: const Color(0xFFEDEFF5),
                     valueColor: const AlwaysStoppedAnimation(Color(0xFF9A2143)),
                   ),
                 ),
               ),
                         SizedBox(height: 4.0,),
             
               Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(uptohow,style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold,color: Colors.black54),),
                   ],
                 ),
               ),
          ],
        ),
      ),
    );
  }
}