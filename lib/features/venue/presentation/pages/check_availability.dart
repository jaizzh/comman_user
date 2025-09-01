// ignore_for_file: deprecated_member_use, avoid_print

import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';

class CheckAvailability extends StatefulWidget {
  const CheckAvailability({super.key});

  @override
  State<CheckAvailability> createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _eventTypeController = TextEditingController();
  final _guestsController = TextEditingController();
  final _requirementsController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _selectedEventType = 'Wedding';

  final List<String> _eventTypes = [
    'Wedding',
    'Birthday Party',
    'Corporate Event',
    'Anniversary',
    'Reception',
    'Engagement',
    'Conference',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _eventTypeController.dispose();
    _guestsController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Check Availability',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        backgroundColor: AppColors.lightGold,
        surfaceTintColor: AppColors.lightGold,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightGold, Colors.white],
            stops: [0.0, 0.40],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(),
                const SizedBox(height: 30),

                // Personal Information Card
                _buildPersonalInfoCard(),
                const SizedBox(height: 20),

                // Event Details Card
                _buildEventDetailsCard(),
                const SizedBox(height: 20),

                // Date & Time Card
                _buildDateTimeCard(),
                const SizedBox(height: 20),

                // Additional Requirements Card
                _buildRequirementsCard(),
                const SizedBox(height: 30),

                // Submit Button
                _buildSubmitButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(Icons.event_available, size: 50, color: AppColors.lightGold),
          SizedBox(height: 15),
          Text(
            'Check Venue Availability',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Fill in your event details to check if the venue is available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return _buildCard(
      title: 'Personal Information',
      icon: Icons.person,
      children: [
        _buildTextField(
          controller: _nameController,
          label: 'Full Name',
          icon: Icons.person_outline,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your name' : null,
        ),
        const SizedBox(height: 15),
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your phone number' : null,
        ),
        const SizedBox(height: 15),
        _buildTextField(
          controller: _emailController,
          label: 'Email Address',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter your email';
            if (!value!.contains('@')) return 'Please enter a valid email';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildEventDetailsCard() {
    return _buildCard(
      title: 'Event Details',
      icon: Icons.event,
      children: [
        _buildDropdown(),
        const SizedBox(height: 15),
        _buildTextField(
          controller: _guestsController,
          label: 'Expected Number of Guests',
          icon: Icons.group,
          keyboardType: TextInputType.number,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter number of guests' : null,
        ),
      ],
    );
  }

  Widget _buildDateTimeCard() {
    return _buildCard(
      title: 'Date & Time',
      icon: Icons.schedule,
      children: [
        _buildDatePicker(),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _buildTimePicker(isStartTime: true)),
            const SizedBox(width: 15),
            Expanded(child: _buildTimePicker(isStartTime: false)),
          ],
        ),
      ],
    );
  }

  Widget _buildRequirementsCard() {
    return _buildCard(
      title: 'Additional Requirements',
      icon: Icons.note_add,
      children: [
        _buildTextField(
          controller: _requirementsController,
          label: 'Special Requirements (Optional)',
          icon: Icons.notes,
          maxLines: 4,
          hint: 'Decoration, catering, music system, etc.',
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.lightGold, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.lightGold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lightGold, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedEventType,
      decoration: InputDecoration(
        labelText: 'Event Type',
        prefixIcon: const Icon(Icons.celebration, color: AppColors.lightGold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lightGold, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: _eventTypes.map((String eventType) {
        return DropdownMenuItem<String>(
          value: eventType,
          child: Text(eventType),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedEventType = newValue;
          });
        }
      },
      validator: (value) =>
          value == null ? 'Please select an event type' : null,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: AppColors.lightGold),
            const SizedBox(width: 12),
            Text(
              _selectedDate == null
                  ? 'Select Event Date'
                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: TextStyle(
                fontSize: 16,
                color: _selectedDate == null ? Colors.grey : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker({required bool isStartTime}) {
    final time = isStartTime ? _startTime : _endTime;
    final label = isStartTime ? 'Start Time' : 'End Time';

    return InkWell(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) {
          setState(() {
            if (isStartTime) {
              _startTime = picked;
            } else {
              _endTime = picked;
            }
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: AppColors.lightGold),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                time == null ? label : time.format(context),
                style: TextStyle(
                  fontSize: 14,
                  color: time == null ? Colors.grey : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
        ),
        child: const Text(
          'Check Availability',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        _showSnackBar('Please select an event date');
        return;
      }
      if (_startTime == null || _endTime == null) {
        _showSnackBar('Please select start and end times');
        return;
      }

      // Create the availability check data
      final availabilityData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'eventType': _selectedEventType,
        'guests': int.tryParse(_guestsController.text) ?? 0,
        'date': _selectedDate!.toIso8601String(),
        'startTime': '${_startTime!.hour}:${_startTime!.minute}',
        'endTime': '${_endTime!.hour}:${_endTime!.minute}',
        'requirements': _requirementsController.text,
      };
      print('Availability check data: $availabilityData');

      _showSuccessDialog();
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Request Sent!'),
            ],
          ),
          content: const Text(
            'Your availability check request has been sent to the vendor. You will receive a confirmation shortly.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: const Text('OK',
                  style: TextStyle(color: AppColors.lightGold)),
            ),
          ],
        );
      },
    );
  }
}
