import 'package:flutter/material.dart';

class EnquiryPage extends StatefulWidget {
  const EnquiryPage({super.key});

  @override
  State<EnquiryPage> createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            textfield(),
          ],
        ),
      ),
    );
  }

  Widget textfield() {
    return const Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
