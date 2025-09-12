import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/pages/vendor_home.dart';
import 'package:common_user/features/vendor/widgets/datepicker.dart';
import 'package:common_user/features/vendor/widgets/notification_helpers.dart';
import 'package:common_user/features/vendor/widgets/validation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnquiryPage extends StatefulWidget {
  final String name, image;
  EnquiryPage({super.key, required this.name, required this.image});

  @override
  State<EnquiryPage> createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  // FocusNodes for validation triggering
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  // Date selected and validation error text for date picker
  DateTime? selectedDate;
  String? dateErrorText;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
    _mobileFocus.addListener(() {
      if (!_mobileFocus.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _detailsController.dispose();

    _nameFocus.dispose();
    _mobileFocus.dispose();
    _emailFocus.dispose();

    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _nameController.text = prefs.getString("name") ?? "";
      _emailController.text = prefs.getString("email") ?? "";
      _mobileController.text = prefs.getString("mobile") ?? "";
    });
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
      dateErrorText = null;
    });
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (selectedDate == null) {
      setState(() {
        dateErrorText = "Please select the event date";
      });
    } else {
      setState(() {
        dateErrorText = null;
      });
    }

    if (!isValid || selectedDate == null) {
      return;
    }

    FocusScope.of(context).unfocus();
    NotificationHelpers.showSnackBar(context, "Message sent successfully");

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VendorHome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// FIRST CONTAINER (IMAGE)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: screenHeight * 0.4,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back,
                        size: 18, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),

          /// SECOND CONTAINER (FORM)
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -60),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapbox(screenHeight),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text(
                            "Hai ${widget.name} ,",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // Full Name
                        textfield(
                          "Full Name *",
                          Icons.person,
                          screenWidth,
                          controller: _nameController,
                          capital: TextCapitalization.words,
                          focusNode: _nameFocus,
                          validator: ValidationHelpers.validateName,
                        ),
                        gapbox(screenHeight),

                        // Mobile
                        textfield(
                          "Mobile Number *",
                          Icons.phone,
                          screenWidth,
                          controller: _mobileController,
                          keyboard: TextInputType.phone,
                          focusNode: _mobileFocus,
                          validator: ValidationHelpers.validateMobile,
                        ),
                        gapbox(screenHeight),

                        // Email
                        textfield(
                          "Email *",
                          Icons.email,
                          screenWidth,
                          controller: _emailController,
                          keyboard: TextInputType.emailAddress,
                          focusNode: _emailFocus,
                          validator: ValidationHelpers.validateEmail,
                        ),
                        gapbox(screenHeight),

                        // Date picker
                        DatePickerContainer(
                          selectedDate: selectedDate,
                          onDateChanged: _onDateChanged,
                          errorText: dateErrorText,
                        ),
                        gapbox(screenHeight),

                        // Event details (optional, no validation)
                        textfield(
                          "Details About Your Event",
                          Icons.notes,
                          screenWidth,
                          controller: _detailsController,
                          capital: TextCapitalization.sentences,
                          keyboard: TextInputType.multiline,
                          max: 5,
                        ),
                        gapbox(screenHeight, values: 0.02),

                        // Send button (tap triggers _submitForm)
                        GestureDetector(
                          onTap: _submitForm,
                          child: send(screenWidth, screenHeight),
                        ),
                        gapbox(screenHeight),

                        Text(
                          textAlign: TextAlign.justify,
                          'Complete information ensures you get accurate and timely vendor responses',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textfield(
    String hint,
    IconData icon,
    double screenWidth, {
    TextEditingController? controller,
    TextCapitalization capital = TextCapitalization.none,
    TextInputType keyboard = TextInputType.text,
    int max = 1,
    FocusNode? focusNode,
    String? Function(String?)? validator,
  }) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: TextFormField(
          controller: controller,
          textCapitalization: capital,
          keyboardType: keyboard,
          minLines: 1,
          maxLines: max,
          focusNode: focusNode,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              icon,
              color: AppColors.primary,
            ),
            labelText: hint,
            labelStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  Widget gapbox(double screenHeight, {double values = 0.01}) {
    return SizedBox(
      height: screenHeight * values,
    );
  }

  Widget send(double screenWidth, double screenHeight) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: AppColors.primary,
      width: screenWidth,
      child: Center(
        child: Text(
          "Send Message",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
