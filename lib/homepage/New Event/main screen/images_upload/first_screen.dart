import 'package:common_user/common/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class uploadpagee extends StatefulWidget {
  const uploadpagee({super.key});

  @override
  State<uploadpagee> createState() => _uploadpageeState();
}

class _uploadpageeState extends State<uploadpagee> {
   final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];

      final ImagePicker defaultpicker = ImagePicker();
  final List<XFile> defaultimages = [];

    Future<void> _pickFromGallery() async {
    final List<XFile> picked = await _picker.pickMultiImage(
      imageQuality: 85,   // optional: compress
      maxWidth: 1920,     // optional: resize
    );
    if (picked.isNotEmpty) {
      setState(() => _images.addAll(picked));
    }
  }

    Future<void> _defaultpickFromGallery() async {
    final List<XFile> defaultpicked = await defaultpicker.pickMultiImage(
      imageQuality: 85,   // optional: compress
      maxWidth: 1920,     // optional: resize
    );
    if (defaultpicked.isNotEmpty) {
      setState(() => defaultimages.addAll(defaultpicked));
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
              children: [
                Column(
                  children: [
                       SizedBox(height: 20.0,),
                       labell("Upload Default Images"),
                       SizedBox(height: 6.0,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
                         child: Text(
                          maxLines: 2,
                          "Upload Yout  default images here. These will be shared automatically when you share your invitation",style: TextStyle(fontSize: 12.0,color: Colors.black54,fontWeight: FontWeight.bold,),),
                       ),
                       defaultupload(),
                        SizedBox(height: 16.0,),
                       labell("Upload Event Images"),
                       SizedBox(height: 6.0,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
                         child: Text(
                          maxLines: 2,
                          "Upload your event images here. And you can also share with selection of images.",style: TextStyle(fontSize: 12.0,color: Colors.black54,fontWeight: FontWeight.bold,),),
                       ),
                       eventupload(),
                  ],
                ),
              ],
            ),
      ),
    );
  }
    Widget labell(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                color: AppColors.buttoncolor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

    Widget defaultupload(){
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: DottedBorder(
        color: Colors.grey.shade400,
        dashPattern: const [6, 6],
        strokeWidth: 1.5,
            //  borderType: BorderType.RRect, 
        radius:  Radius.circular(12),
        child: GestureDetector(
          onTap: () {
            _defaultpickFromGallery();
          },
          child: Container(
            height: 150,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.image, size: 40, color: Colors.grey),
                SizedBox(height: 8),
                Text("Click Here"),
              ],
            ),
          ),
        ),
            ),
      );
  }
      Widget eventupload(){
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: DottedBorder(
        color: Colors.grey.shade400,
        dashPattern: const [6, 6],
        strokeWidth: 1.5,
            //  borderType: BorderType.RRect, 
        radius:  Radius.circular(12),
        child: GestureDetector(
          onTap: () {
            _pickFromGallery();
          },
          child: Container(
            height: 150,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.image, size: 40, color: Colors.grey),
                SizedBox(height: 8),
                Text("Click Here"),
              ],
            ),
          ),
        ),
            ),
      );
  }

}