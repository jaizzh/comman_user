import 'dart:io';
import 'package:common_user/homepage/dashboard%20page/invites_visit/widgets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ourimageview extends ConsumerStatefulWidget {
  const ourimageview({super.key});

  @override
  ConsumerState<ourimageview> createState() => _ourimageviewState();
}

class _ourimageviewState extends ConsumerState<ourimageview> {
  @override
  Widget build(BuildContext context) {
    final imagee = ref.watch(yourimageriverpod);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Upload Your Image",
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    crossAxisCount: 3),
                itemCount: imagee.length, // add this line
                itemBuilder: (context, index) {
                  XFile value = imagee[index];
                  return Image.file(
                    File(value.path),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
