// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/data/event_data.dart';
import 'package:common_user/features/product/model/event_model.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/widgets/confirm_alertBox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChooseGiftregistryEventPage extends StatefulWidget {
  final Product product;
  const ChooseGiftregistryEventPage({super.key, required this.product});

  @override
  State<ChooseGiftregistryEventPage> createState() =>
      _ChooseGiftregistryEventPageState();
}

class _ChooseGiftregistryEventPageState
    extends State<ChooseGiftregistryEventPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.paper,
        appBar: AppBar(
          title: Text(
            "Choose Event",
            style: GoogleFonts.poppins(
              fontSize: 17,
            ),
          ),
          backgroundColor: AppColors.paper,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title("Product Details", 14, AppColors.black,
                  fontWeight: FontWeight.w500),
              gapBox(screenHeight, values: 0.01),
              productShow(),
              gapBox(screenHeight),
              title("Choose Event", 14, AppColors.black,
                  fontWeight: FontWeight.w500),
              gapBox(screenHeight, values: 0.01),
              eventShow(),
              gapBox(screenHeight, values: 0.03),
              title(
                "You can pick from your created events. Friends & family will see this product under the selected event.",
                12,
                AppColors.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              gapBox(screenHeight, values: 0.01),
              addButton()
            ],
          ),
        ));
  }

  Widget productShow() {
    return Card(
      elevation: 5,
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10)),
        tileColor: AppColors.lightGold.withOpacity(0.5),
        leading: Image.asset(widget.product.image),
        title: Text(
          widget.product.name,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        subtitle: Text(
          widget.product.description,
          style: GoogleFonts.poppins(fontSize: 10),
        ),
        trailing: Text(
          "₹ ${widget.product.price.toString()}",
          style: GoogleFonts.poppins(
              fontSize: 17,
              color: AppColors.primary,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget title(String title, double size, Color tcolors,
      {FontWeight fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.start}) {
    return Text(
      title,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
          fontSize: size, color: tcolors, fontWeight: fontWeight),
    );
  }

  Widget gapBox(double screenHeight, {double values = 0.02}) {
    return SizedBox(height: screenHeight * values);
  }

  Widget eventShow() {
    return Flexible(
      fit: FlexFit.loose,
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lightGold.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: eventdata.length,
            itemBuilder: (context, index) {
              EventModel event = eventdata[index];
              String formattedDate = DateFormat.yMMMd().format(event.date);
              bool isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.lightGold),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(event.name),
                      subtitle: Text(event.type),
                      trailing: Text(formattedDate),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return GestureDetector(
      onTap: () {
        showConfirmAlretBox(context, widget.product, eventdata[selectedIndex]);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.primary),
        child: Center(
          child: Text(
            "Add to Gift Registry",
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
