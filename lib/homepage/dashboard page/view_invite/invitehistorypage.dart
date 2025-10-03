import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';

class invitehistory extends StatefulWidget {

  const invitehistory({super.key,});

  @override
  State<invitehistory> createState() => _invitehistoryState();
}

class _invitehistoryState extends State<invitehistory> {
  final List<Map> history = [
    {
      "eventname" : "Ayudha Pooja",
      "startdate" : "11/2/2026",
      "enddate"  : "24/2/2026",
    },
     {
      "eventname" : "farewell party",
      "startdate" : "14/04/2026",
      "enddate"  : "20/04/2026",
    },
     {
      "eventname" : "vini birthday party",
      "startdate" : "04/12/2025",
      "enddate"  : "11/12/2025",
    }


  ];
@override
void initState() {
  super.initState();
  headingavaialble = false;
}

  bool headingavaialble = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: Text("History Of Events",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_rounded,size: 22.0,color: AppColors.primary,)),
      ),
      body: SafeArea(child: Container(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            if(headingavaialble == false) heading(),
            // if(headingavaialble == false) SizedBox(height: 16.0,),
            Expanded(child: historyevents()),
          ],
        ),
      )),
    );
  }

  Widget heading(){
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(1.0)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween
            ,
            children: [
              Text("History Are Displayed For Upto 30 Days",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.white),),
              IconButton(onPressed: (){
           setState(() {
            headingavaialble = true;
          });
              }, icon: Icon(Icons.close,color: Colors.white,))
            ],
          ),
        ),
      ),
    );
  }

  Widget historyevents(){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.paper,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.black12
          )
        ]
      ),
      child: ListView.builder(
        itemCount: history.length ,
        itemBuilder: (context,index){
          final valueshistory = history[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
            child: Card(
              elevation: 3.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.black12
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child:  Row(
                      children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(valueshistory["eventname"]),
                    Row(children: [
                      Text(valueshistory["startdate"]),
                      Text(valueshistory["enddate"])
                    ],)
                ],
              )
                      ],
                    ),
              ),
            ),
          );
        }
        ) 
    );
  }
}