
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/grouping/grouping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ContactSelectionPage extends StatefulWidget {
  final List<Contact> contacts;
  final List<Contact> initiallySelected;

  const ContactSelectionPage({Key? key, required this.contacts, required this.initiallySelected}) : super(key: key);

  @override
  State<ContactSelectionPage> createState() => _ContactSelectionPageState();
}

class _ContactSelectionPageState extends State<ContactSelectionPage> {
 Set<Contact> _selected = {};

  @override
  void initState() {
    super.initState();
  //  _selected =   widget.initiallySelected.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.push(context, (MaterialPageRoute(builder: (_)=> ContactPickerApp() )));
        }, icon: Icon(Icons.arrow_back,size: 16.0,color: Colors.black,)),
        title: const Text('Select Contacts',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, _selected.toList());
            },
            child: const Text('Done', style: TextStyle(color: Colors.green)),
          ),
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
