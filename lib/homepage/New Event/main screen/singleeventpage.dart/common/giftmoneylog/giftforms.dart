import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';

class giftlogforms extends StatefulWidget {
  const giftlogforms({super.key});

  @override
  State<giftlogforms> createState() => _giftlogformsState();
}

class _giftlogformsState extends State<giftlogforms> {
  TextEditingController form1 = TextEditingController();
  TextEditingController form2 = TextEditingController();
  TextEditingController form3 = TextEditingController();
  TextEditingController form4 = TextEditingController();
  TextEditingController form5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.04,
            top: 8,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 20, // Responsive icon size
            ),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text(
          "Gift/Money Log",
          style: TextStyle(
            fontSize: 16.0, // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            textforms(
                hint: "Name", contname: form1, iconwidget: Icons.person_2),
            SizedBox(
              height: 20.0,
            ),
            textforms(
                hint: "Mobile Number",
                contname: form1,
                iconwidget: Icons.mobile_friendly_rounded),
            SizedBox(
              height: 20.0,
            ),
            textforms(
                hint: "Address",
                contname: form1,
                iconwidget: Icons.local_activity_rounded),
            SizedBox(
              height: 20.0,
            ),
            textforms(
                hint: "Gift Name",
                contname: form1,
                iconwidget: Icons.card_giftcard_rounded),
          ],
        ),
      )),
    );
  }

  Widget textforms(
      {required String hint,
      required TextEditingController contname,
      required IconData iconwidget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14.0,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: Colors.black26,
                  offset: Offset(0, 1))
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: contname,
            validator: (value) {
              if (value.toString().isNotEmpty && value.toString().length <= 3)
                return "more than 3 characters";
            },
            textCapitalization: TextCapitalization.sentences,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  iconwidget,
                  color: Colors.black54,
                  size: 20.0,
                ),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)),
          ),
        ),
      ),
    );
  }
}

class checkboxes extends StatefulWidget {
  final String firstname;
  const checkboxes({super.key, required this.firstname});

  @override
  State<checkboxes> createState() => _checkboxesState();
}

class _checkboxesState extends State<checkboxes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.firstname),
          SizedBox(
            height: 14.0,
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
