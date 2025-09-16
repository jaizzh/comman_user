import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/pages/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchfilter extends StatefulWidget {
  const Searchfilter({super.key});

  @override
  State<Searchfilter> createState() => _SearchfilterState();
}

class _SearchfilterState extends State<Searchfilter> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: GestureDetector(
            onTap: () {},
            child: Card(
              shadowColor: AppColors.primary,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: width * 0.025),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 241, 245)),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Search your Products",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.02),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              navigateWithSlide(context, const FilterPage());
            },
            child: Container(
              padding: EdgeInsets.all(width * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: const Center(
                child: Icon(Icons.tune, color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
