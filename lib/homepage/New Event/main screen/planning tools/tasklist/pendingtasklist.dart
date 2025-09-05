import 'package:flutter/material.dart';

class pendingtask extends StatefulWidget {
  final List<String> taskNames;
  final List<String> taskTimes;
 pendingtask({super.key, required this.taskNames, required this.taskTimes});

  @override
  State<pendingtask> createState() => _pendingtaskState();
}

class _pendingtaskState extends State<pendingtask> {
  late List<String> completetaskNames;
  late List<String> completetaskTimes;
  late final List<String> pendingtaskNames = widget.taskNames;
   late final List<String> pendingtaskTimes = widget.taskTimes;

  var pendtocomp = false;
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
                Text("Pending TaskList",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w600,color: Colors.black),),
                IconButton(onPressed: (){}, icon:Icon(Icons.shopping_cart,size: 18.0,color: Colors.black87,)),
              ],
             ),
           ),
          // SizedBox(height: 20.0,),
            Expanded(
              child: ListView.builder(
                itemCount: pendingtaskNames.length,
                itemBuilder: (context,index){
                  final tasknameone = pendingtaskNames[index];
                  final tasktimeone = pendingtaskTimes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
                    child: GestureDetector(
                      onTap: ()async {
                        final ok = await   pendingalertdialog(context);
                        if( ok == true){
                          setState(() {
                          pendingtaskNames.removeAt(index);
                          pendingtaskTimes.removeAt(index);
                          completetaskNames.add(tasknameone);
                          completetaskTimes.add(tasktimeone);

                          });
                        }
                      
                     },
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tasknameone,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black),),
                               // SizedBox(height: 6.0,),
                                Text(tasktimeone,style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,color: Colors.black54),),
                              ],
                            ),
                             Icon(Icons.circle_outlined,color: Colors.red.shade300,),
                          ],
                        ),
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
Future<bool?> pendingalertdialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(
          "Complete Task",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Text(
          "Did you complete this task?",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return "No"
            },
            child: Text(
              "No",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {

                pendtocomp = true;
              });
              Navigator.of(context).pop(true); // Return "Yes"
            },
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      );
    },
  );
}

}