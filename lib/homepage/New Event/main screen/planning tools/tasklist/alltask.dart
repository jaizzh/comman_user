import 'package:flutter/material.dart';

class alltasklist extends StatefulWidget {
   final List<String> taskNamesall;
  final List<String> taskTimesall;
  const alltasklist({super.key, required this.taskNamesall, required this.taskTimesall});

  @override
  State<alltasklist> createState() => _alltasklistState();
}

class _alltasklistState extends State<alltasklist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
           // SizedBox(height: 16.0,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All TaskList",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w600,color: Colors.black),),
                IconButton(onPressed: (){}, icon:Icon(Icons.shopping_cart,size: 18.0,color: Colors.black87,)),
              ],
             ),
           ),
          // SizedBox(height: 20.0,),
            Expanded(
              child: ListView.builder(
                itemCount: widget.taskNamesall.length,
                itemBuilder: (context,index){
                  final tasknameone = widget.taskNamesall[index];
                  final tasktimeone = widget.taskTimesall[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tasknameone,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black),),
                             // SizedBox(height: 6.0,),
                              Text(tasktimeone,style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,color: Colors.black54),),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
            )
          ],
        ),
      ),
    );
  }
}