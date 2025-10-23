import 'dart:io';

import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/widgets/riverpod.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ourimagepage extends ConsumerStatefulWidget {
  const ourimagepage({super.key});

  @override
  ConsumerState<ourimagepage> createState() => _ourimagepageState();
}

class _ourimagepageState extends ConsumerState<ourimagepage> {
  List<XFile> galleryimages = [];
  XFile? cameraimages;
  List<XFile> yourimages = [];

  Future<void> pickitgallery() async {
    final List<XFile>? gallerypick = await ImagePicker().pickMultiImage(
      requestFullMetadata: true,
    );
    if (gallerypick != null && gallerypick.isNotEmpty) {
      setState(() {
        galleryimages.addAll(gallerypick);
        yourimages.addAll(galleryimages);
      });
    }
  }

  Future<void> pickitcamera() async {
    final XFile? camerapick =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (camerapick != null) {
      setState(() {
        cameraimages = camerapick;
        yourimages.add(cameraimages!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        child: MaterialButton(
          color: AppColors.primary, // 🔸 custom brand color
          elevation: 3,
          height: 55,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: () {
            ref.read(yourimageriverpod.notifier).state =
                List<XFile>.from(yourimages);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Updated successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            // ref.read(yourimageriverpod.notifier).update((list) {
            //   final newList = List<XFile>.from(list);
            //   return newList;
            // });
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text("Updated successfully!"),
            //     backgroundColor: Colors.green,
            //     duration: Duration(seconds: 2),
            //   ),
            // );
          },
          child: Text(
            "Send To Event Host -> ",
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            about(),
            SizedBox(
              height: 10.0,
            ),
            uploadimage(),
            SizedBox(
              height: 20.0,
            ),
            if (yourimages.isNotEmpty) imageheading(),
            Expanded(child: imagesshow()),
          ],
        ),
      )),
    );
  }

  Widget about() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Share Your Moment ",
          style: GoogleFonts.sahitya(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          maxLines: 3,
          "Snap it. Share it. Shine it.✨Upload your image and let others see your vibe.Your moment deserves to be remembered.Turn every click into a story worth sharing.",
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
      ],
    );
  }

  Widget uploadimage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DottedBorder(
          color: AppColors.primary,
          dashPattern: [10, 3],
          child: GestureDetector(
            onTap: () {
              pickitgallery();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file_rounded,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Upload From Gallery",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        DottedBorder(
          color: AppColors.primary,
          dashPattern: [10, 3],
          child: GestureDetector(
            onTap: () {
              pickitcamera();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Take Photo",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imageheading() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Your Shared Images(${yourimages.length})",
              style: GoogleFonts.sahitya(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary),
            ),
          ],
        ),
        Text("")
      ],
    );
  }

  Widget imagesshow() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, crossAxisCount: 3),
      itemCount: yourimages.length, // add this line
      itemBuilder: (context, index) {
        XFile value = yourimages[index];
        return Image.file(
          File(value.path),
          fit: BoxFit.cover,
        );
      },
    );
  }
}
