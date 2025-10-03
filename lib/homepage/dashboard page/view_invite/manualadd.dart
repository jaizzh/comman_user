import 'package:flutter/material.dart';
import 'package:common_user/app_colors.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:intl/intl.dart';

// Main function to show manual invite sheet
Future<void> manualinvitesheet(BuildContext context, {required Function(Map<dynamic, dynamic>) onEventAdded}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7, // Fixed height
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                // Handle bar for better UX
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Scrollable content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: manualcontainer(onEventAdded: onEventAdded),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class manualcontainer extends StatefulWidget {
  final Function(Map<dynamic, dynamic>) onEventAdded;
  
  const manualcontainer({super.key, required this.onEventAdded});

  @override
  State<manualcontainer> createState() => _manualcontainerState();
}

class _manualcontainerState extends State<manualcontainer> {
  final TextEditingController namecont = TextEditingController();
  final TextEditingController startdatecont = TextEditingController();
  final TextEditingController enddatecont = TextEditingController();
  final TextEditingController eventaddresscont = TextEditingController();
  final TextEditingController relationship = TextEditingController();
  final TextEditingController maplinkcont = TextEditingController();
  final TextEditingController eventcitycont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), // Better scroll physics
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0), // Bottom padding for scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Manual Event Entry",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            const Text(
              "Add all details step by step, without relying on automation. "
              "Perfect for unique or customized occasions that need flexibility. "
              "Quick, simple, and always in your hands.",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 14.0),
            manualentrytext(context, hintText: 'Name Of The Event', controller: namecont),
            const SizedBox(height: 14.0),
            datecontainer(
              context,
              "Start Date",
              startdatecont,
              () async {
                await datePicker(context, startdatecont);
                setState(() {});
              },
            ),
            const SizedBox(height: 14.0),
            datecontainer(
              context,
              "End Date",
              enddatecont,
              () async {
                await datePicker(context, enddatecont);
                setState(() {});
              },
            ),
            const SizedBox(height: 14.0),
            directGooglePlacesCityField(),
            const SizedBox(height: 14.0),
            manualentrytext(context, hintText: "Event Address", controller: eventaddresscont),
            const SizedBox(height: 14.0),
            manualentrytext(context, hintText: "Relationship", controller: relationship),
            const SizedBox(height: 14.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "Copy And Paste the google map link here (optional)*",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            manualentrytext(context, hintText: "Google Map Link", controller: maplinkcont),
            const SizedBox(height: 24.0),
            submitbutton(submitpress: () {
              // Validate required fields
              if (namecont.text.isEmpty || startdatecont.text.isEmpty || enddatecont.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please fill in all required fields'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

              // Create the new event
              Map<dynamic, dynamic> newEvent = {
                "eventname": namecont.text,
                "startdate": startdatecont.text,
                "enddate": enddatecont.text,
                "address": eventaddresscont.text,
                "city": eventcitycont.text,
                "relationship": relationship.text,
                "maplink": maplinkcont.text,
              };
              
              // Call the callback to add to parent list
              widget.onEventAdded(newEvent);
              
              // Clear form fields
              namecont.clear();
              startdatecont.clear();
              enddatecont.clear();
              eventaddresscont.clear();
              relationship.clear();
              maplinkcont.clear();
              eventcitycont.clear();
              
              Navigator.pop(context); // Close the sheet
            }),
            const SizedBox(height: 40.0), // Extra bottom padding for scroll
          ],
        ),
      ),
    );
  }

  Widget directGooglePlacesCityField() {
    return Card(
      elevation: 3.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black26,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GooglePlacesAutoCompleteTextFormField(
          textEditingController: eventcitycont,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          config: GoogleApiConfig(
            apiKey: 'AIzaSyAniSx-36EEgjf0xdXAhLOwlZT3Iqtmp_E',
            debounceTime: 600,
            countries: ['in'],
            fetchPlaceDetailsWithCoordinates: true,
            placeTypeRestriction: PlaceType.city,
          ),
          decoration: InputDecoration(
            hintText: 'Search city...',
            hintStyle: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            border: InputBorder.none,
          ),
          onSuggestionClicked: (prediction) {
            eventcitycont.text = prediction.description ?? '';
            eventcitycont.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0),
            );
            print('Selected city: ${prediction.description}');
          },
          onPredictionWithCoordinatesReceived: (prediction) {
            print("Coordinates: (${prediction.lat}, ${prediction.lng})");
          },
        ),
      ),
    );
  }

  Future<void> datePicker(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2024),
      lastDate: DateTime.utc(2030),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  }

  Widget submitbutton({required VoidCallback submitpress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: submitpress,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              "Submit",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget datecontainer(
    BuildContext context,
    String hint,
    TextEditingController controller,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black26,
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.text.isEmpty ? hint : controller.text,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: controller.text.isEmpty ? Colors.black54 : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget manualentrytext(
    BuildContext context, {
    required String hintText,
    required TextEditingController controller,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black26,
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            controller: controller,
            readOnly: onTap != null,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
