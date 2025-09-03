import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

enum FilterSection { categories, price, ratings, district, foodType, capacity }

class _FilterPageState extends State<FilterPage> {
  FilterSection _selectedSection = FilterSection.categories;

  // ---- Data ----
  final List<String> _leftMenu = [
    'Categories',
    'Price',
    'Ratings',
    'District',
    'Food Type',
    'Capacity'
  ];

  final Map<FilterSection, List<String>> _options = {
    FilterSection.categories: [
      'Banquet',
      'Hall',
      'Outdoor',
      'Resort',
      'Hotel',
      'Marriage Hall',
      'Community Center',
    ],
    FilterSection.price: [
      'Above ₹10k',
      'Above ₹50k',
      'Above ₹1L',
    ],
    FilterSection.ratings: [
      '1 Star & Above',
      '2 Stars & Above',
      '3 Stars & Above',
      '4 Stars & Above',
      '5 Stars',
    ],
    FilterSection.district: [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Salem',
      'Tiruchirappalli',
      'Tirunelveli',
      'Erode',
      'Vellore',
    ],
    FilterSection.foodType: [
      'Veg',
      'Non-Veg',
      'Both',
    ],
    FilterSection.capacity: [
      '0-100',
      '100-200',
      '200-500',
      '500+',
    ],
  };

  // ---- Selections ----
  final Map<FilterSection, Set<String>> _selectedValues = {
    FilterSection.categories: {},
    FilterSection.price: {},
    FilterSection.ratings: {},
    FilterSection.district: {},
    FilterSection.foodType: {},
    FilterSection.capacity: {},
  };

  void _toggleSelection(String item) {
    final selectedSet = _selectedValues[_selectedSection]!;

    setState(() {
      if (_selectedSection == FilterSection.price ||
          _selectedSection == FilterSection.foodType ||
          _selectedSection == FilterSection.capacity ||
          _selectedSection == FilterSection.ratings) {
        // Single Selection Logic (Radio Button behavior)
        selectedSet.clear();
        selectedSet.add(item);
      } else {
        // Multiple Selection Logic (Checkbox behavior)
        if (selectedSet.contains(item)) {
          selectedSet.remove(item);
        } else {
          selectedSet.add(item);
        }
      }
    });
  }

  void _clearAll() {
    setState(() {
      for (var key in _selectedValues.keys) {
        _selectedValues[key]!.clear();
      }
    });
  }

  void _applyFilters() {
    Navigator.pop(context, _selectedValues);
  }

  Widget _buildFilterItem(String item) {
    final isSelected = _selectedValues[_selectedSection]!.contains(item);

    // Single selection sections (Radio button style)
    if (_selectedSection == FilterSection.price ||
        _selectedSection == FilterSection.foodType ||
        _selectedSection == FilterSection.capacity ||
        _selectedSection == FilterSection.ratings) {
      return RadioListTile<String>(
        title: Text(
          item,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        value: item,
        groupValue: _selectedValues[_selectedSection]!.isEmpty
            ? null
            : _selectedValues[_selectedSection]!.first,
        onChanged: (value) {
          if (value != null) {
            _toggleSelection(value);
          }
        },
        activeColor: AppColors.primary,
        controlAffinity: ListTileControlAffinity.trailing,
      );
    } else {
      // Multiple selection sections (Checkbox style)
      return CheckboxListTile(
        title: Text(
          item,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        value: isSelected,
        onChanged: (_) => _toggleSelection(item),
        activeColor: AppColors.primary,
        controlAffinity: ListTileControlAffinity.trailing,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const Icon(Icons.filter_list, color: Colors.black),
        title: Text(
          "Filter",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          InkWell(
            onTap: _clearAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text(
                  "Clear All",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // ---- Left Menu ----
                Container(
                  width: screenWidth * 0.35,
                  color: Colors.grey[200],
                  child: ListView.builder(
                    itemCount: _leftMenu.length,
                    itemBuilder: (context, index) {
                      final section = FilterSection.values[index];
                      final isActive = _selectedSection == section;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedSection = section;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                          color: isActive ? Colors.white : Colors.grey[200],
                          child: Text(
                            _leftMenu[index],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight:
                                  isActive ? FontWeight.w600 : FontWeight.w500,
                              color:
                                  isActive ? AppColors.primary : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ---- Right Panel ----
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      children: _options[_selectedSection]!
                          .map((item) => _buildFilterItem(item))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---- Bottom Buttons ----
          Container(
            height: screenHeight * 0.07,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "CLOSE",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: _applyFilters,
                  child: Text(
                    "APPLY",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
