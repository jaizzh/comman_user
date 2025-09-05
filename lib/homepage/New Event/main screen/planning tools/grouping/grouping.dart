import 'package:common_user/common/colors.dart';
import 'package:common_user/common/mobile%20contacts/groupingcontact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPickerApp extends StatefulWidget {
  const ContactPickerApp({Key? key}) : super(key: key);

  @override
  State<ContactPickerApp> createState() => _ContactPickerAppState();
}

class _ContactPickerAppState extends State<ContactPickerApp> {
  List<Contact> _allContacts = [];
  List<Contact> _selectedContacts = [];
  List<String> _groupingList = [];
 // bool addgrouping = false;

  Future<void> _pickMultipleContacts() async {
    PermissionStatus status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
      if (!status.isGranted) {
        if (status.isPermanentlyDenied) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Permission required'),
              content: const Text('Please enable contacts permission in app settings to select contacts.'),
              actions: [
                TextButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: const Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
          return;
        } else {
          // Permission denied (not permanent)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contacts permission denied')),
          );
          return;
        }
      }
    }

    // Permission granted, fetch contacts
    bool flutterContactPermission = await FlutterContacts.requestPermission();
    if (!flutterContactPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacts permission denied')),
      );
      return;
    }

    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
    setState(() {
      _allContacts = contacts;
    //  _selectedContacts.clear();
    });

    // Open selection page
    final List<Contact>? results = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContactSelectionPage(
          contacts: _allContacts,
          initiallySelected: _selectedContacts,
        ),
      ),
    );

    // Get selected contacts result
    if (results != null) {
      setState(() {
        _selectedContacts = results;
      });

      for (var c in _selectedContacts) {
        print('Selected: ${c.displayName}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            height: MediaQuery.of(context).size.height * 0.3,
            "assets/images/grouping.jpg"),
          groupingheading(),
          SizedBox(height: 10.0,),
          if(_selectedContacts.length > 1) line(),
            SizedBox(height: 10.0,),
            if(_selectedContacts.length > 1) totalgroupingpeoples(),
             SizedBox(height: 10.0,),
             Expanded(child: ListView.builder(
              itemCount: _groupingList.length,
              itemBuilder: (context,index){
            //    final groupingname = _groupingList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      showsheet(context);
                      //
                      //
                      //
                      //
                      //
                    
                    },
                   child:   Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          spreadRadius: 1,
          blurRadius: 1,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: name
        Row(
          children: [
            Text(
              _groupingList[index],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
Row(
  children: [
 Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black12,
              )
            ]
          ),
          child: Row(
                      children: [
          const Icon(Icons.person, color: Colors.black54, size: 18),
          const SizedBox(width: 6),
          Text(
            _selectedContacts.length.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
                      ],
                    ) 
        ),
 SizedBox(width: 1.0,),
          IconButton(onPressed: (){
           setState(() {
             _groupingList.removeAt(index);
           });
      }, icon: Icon(Icons.delete,color: Colors.red,size: 20.0,))
  ],
),
      ],
    ),
  ),
                  ),
                );
             })),
        ],
      ),
    );
  }
    Widget groupingheading(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Grouping Your Contacts",style: GoogleFonts.sahitya( fontSize: 16.0,fontWeight: FontWeight.bold,color: AppColors.buttoncolor)),
              Text("Event - Birthday",style: GoogleFonts.mPlus1( fontSize: 11.0,fontWeight: FontWeight.bold,color: Colors.black54)),
            ],
          ),
           GestureDetector(
            onTap: () async {
              showGroupingNameDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.buttoncolor,
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                child: Row(
                  children: [
                    Icon(Icons.add,color: Colors.white,),
                    Text("Add Grouping",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget line(){
    return Center(
      child: Container(
        height: 2.0,
        width: MediaQuery.of(context).size.width * 0.9,
        color: AppColors.buttoncolor,
      ),
    );
  }
   Widget totalgroupingpeoples(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Text("Total Grouping Peoples = 8",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black),),
        ),
        ] 
      ),
    );
  }
  Future<void>  showsheet(BuildContext context){
    return showModalBottomSheet(context: context, shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ), builder: (_){
      return SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.6,
          child:Column(
            children: [
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Your Contacts",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black),)],),
               SizedBox(height: 12.0,),
              Expanded(
                child: ListView.builder(
                            itemCount: _selectedContacts.length,
                            itemBuilder:(context ,index){
                             final contact = _selectedContacts[index];
                            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.black26,
                      ),
                    ]
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0,),
                      Text(contact.displayName,),
                      SizedBox(height: 2.0,),
                       Text(contact.phones.isNotEmpty ? contact.phones.first.number : 'No phone'),
                         SizedBox(height: 6.0,),
                    ],
                  ),
                ),
                            );
                            //
                            //
                            //
                            //
                          } ),
              ),
            ],
          ) 
        ),
      );
    });
  }

Future<void> showGroupingNameDialog(BuildContext context) async {
  final TextEditingController _controller = TextEditingController();

  return showDialog(
    context: context,
    barrierDismissible: false, // prevent dismiss on tap outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: const Text(
          "Grouping name",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              maxLength: 25,
              decoration: InputDecoration(
                hintText: "Enter your grouping name",
                hintStyle: TextStyle(fontSize: 13.0,color: Colors.black54),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
               final enteredText = _controller.text.trim();
                 if (enteredText.isNotEmpty) {
                   Navigator.of(context).pop();
                   _groupingList.add(_controller.text); 
              _pickMultipleContacts();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a grouping name")),
                );
              }
            },
            child: const Text("Okay"),
          ),
        ],
      );
    },
  );
}

}
