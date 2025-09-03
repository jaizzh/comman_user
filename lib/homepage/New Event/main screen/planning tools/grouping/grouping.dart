import 'package:common_user/common/colors.dart';
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
  bool addgrouping = false;

  Future<void> _pickMultipleContacts() async {
    // Check and request permission via permission_handler
    PermissionStatus status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
      if (!status.isGranted) {
        if (status.isPermanentlyDenied) {
          // Permission permanently denied, show dialog to open app settings
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
      body: Column(
        children: [
          groupingheading(),
          ElevatedButton(
            onPressed: _pickMultipleContacts,
            child: const Text('Select Contacts'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedContacts.length,
              itemBuilder: (context, index) {
                final contact = _selectedContacts[index];
                return ListTile(
                  title: Text(contact.displayName),
                  subtitle: Text(contact.phones.isNotEmpty ? contact.phones.first.number : 'No phone'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
    Widget groupingheading(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0,),
              Text("Grouping Your Contacts",style: GoogleFonts.sahitya( fontSize: 16.0,fontWeight: FontWeight.bold,color: AppColors.buttoncolor)),
              Text("Event - Birthday",style: GoogleFonts.mPlus1( fontSize: 11.0,fontWeight: FontWeight.bold,color: Colors.black54)),
            ],
          ),
          if(addgrouping == false) GestureDetector(
            onTap: () {
              setState(() {
                addgrouping = true;
              });
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
          if(addgrouping == true) Container(
            child: IconButton(onPressed: (){
              setState(() {
                addgrouping = false;
              });
            }, icon: Icon(Icons.close,color: AppColors.buttoncolor,)),
          ),
 

        ],
      ),
    );
  }
}

class ContactSelectionPage extends StatefulWidget {
  final List<Contact> contacts;
  final List<Contact> initiallySelected;

  const ContactSelectionPage({Key? key, required this.contacts, required this.initiallySelected}) : super(key: key);

  @override
  State<ContactSelectionPage> createState() => _ContactSelectionPageState();
}

class _ContactSelectionPageState extends State<ContactSelectionPage> {
  late Set<Contact> _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initiallySelected.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, _selected.toList());
            },
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.contacts.length,
        itemBuilder: (context, index) {
          final contact = widget.contacts[index];
          final isSelected = _selected.contains(contact);
          return ListTile(
            title: Text(contact.displayName),
            subtitle: Text(contact.phones.isNotEmpty ? contact.phones.first.number : 'No phone'),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _selected.add(contact);
                  } else {
                    _selected.remove(contact);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
