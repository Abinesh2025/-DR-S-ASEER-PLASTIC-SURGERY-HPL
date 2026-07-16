import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PatientSelectionWidget extends StatefulWidget {
  final Function(String selectionType, Map<String, String>? patientDetails) onSelectionChanged;

  const PatientSelectionWidget({Key? key, required this.onSelectionChanged}) : super(key: key);

  @override
  State<PatientSelectionWidget> createState() => _PatientSelectionWidgetState();
}

class _PatientSelectionWidgetState extends State<PatientSelectionWidget> {
  String _selectedOption = 'me';

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();

  String? _selectedGender;
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _bloodGroupController.dispose();
    super.dispose();
  }

  void _clearAllFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _ageController.clear();
    _emailController.clear();
    _dobController.clear();
    _bloodGroupController.clear();
    _selectedGender = null;
  }

  void _handleSelection(String option) {
    if (_selectedOption == option) return; // Prevent clearing if tapping same tab

    setState(() {
      _selectedOption = option;
      _clearAllFields(); // 🔥 Clear everything on tab change
    });
    _notifyParent();
  }

  // Inside _PatientSelectionWidgetState
  // Inside _PatientSelectionWidgetState in PatientSelectionWidget.dart
  void _notifyParent() {
    if (_selectedOption == 'me') {
      widget.onSelectionChanged('me', null);
    } else {
      widget.onSelectionChanged('someone_else', {
        // "name": "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}",
        "first_name": _firstNameController.text.trim(),
        "last_name": _lastNameController.text.trim(),
        "phone": _phoneController.text.trim(),
        "age": _ageController.text.trim(),
        "gender": _selectedGender?.toLowerCase() ?? '',
        "dob": _dobController.text.trim(),
        "blood_group": _bloodGroupController.text.trim(),
        "email": "", // Skipped in UI
        "relation": "Other", // Default value
      });
    }
  }

  // 🔥 1. Cupertino Date Picker Implementation
  void _showDatePicker() {
    DateTime tempDate = DateTime(2000, 1, 1); // Default initial date

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            _pickerHeader("Select Date of Birth", onDone: () {
              setState(() {
                _dobController.text = DateFormat('yyyy-MM-dd').format(tempDate);
              });
              _notifyParent();
              Navigator.pop(context);
            }),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  tempDate = newDate; // Just update temp variable
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 🔥 2. Cupertino Dropdown (Picker) Implementation
  void _showCupertinoPicker({
    required List<String> options,
    required String title,
    required Function(String) onSelected,
  }) {
    // Store the temporary index (default to 0)
    int tempIndex = 0;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            // Updated Header with logic for the "Done" button
            _pickerHeader(title, onDone: () {
              onSelected(options[tempIndex]);
              Navigator.pop(context);
            }),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (index) {
                  tempIndex = index; // Update temp index as user scrolls
                },
                children: options.map((e) => Center(child: Text(e))).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _pickerHeader(String title, {required VoidCallback onDone}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyleConst.boldTextStyle(Colors.black87, 14)),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onDone, // Trigger the logic passed from the picker
            child: const Text("Done", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Who is this appointment for?", style: TextStyleConst.boldTextStyle(Colors.black87, 18)),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _buildSelectionCard(title: "For Me", icon: Icons.person_outline, value: 'me')),
            const SizedBox(width: 15),
            Expanded(child: _buildSelectionCard(title: "Someone Else", icon: Icons.group_outlined, value: 'someone_else')),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: _selectedOption == 'someone_else' ? _buildSomeoneElseForm() : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildSelectionCard({required String title, required IconData icon, required String value}) {
    final isSelected = _selectedOption == value;
    return GestureDetector(
      onTap: () => _handleSelection(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? ColorConst.primaryColor.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? ColorConst.primaryColor : Colors.grey.shade200, width: isSelected ? 2 : 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: isSelected ? ColorConst.primaryColor : Colors.grey.shade500),
            const SizedBox(width: 8),
            Text(title, style: TextStyleConst.boldTextStyle(isSelected ? ColorConst.primaryColor : Colors.black87, 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildSomeoneElseForm() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConst.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.person_add_alt_1, size: 20, color: ColorConst.primaryColor),
              ),
              const SizedBox(width: 12),
              Text("Patient Information", style: TextStyleConst.boldTextStyle(Colors.black87, 16)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(height: 1),
          ),

          // --- Name Row ---
          Row(
            children: [
              Expanded(child: _buildFieldLabel("First Name", _firstNameController, Icons.person_outline)),
              const SizedBox(width: 12),
              Expanded(child: _buildFieldLabel("Last Name", _lastNameController, null)),
            ],
          ),
          const SizedBox(height: 16),

          // --- Contact & Relationship ---
          _buildFieldLabel("Phone Number", _phoneController, Icons.phone_android_outlined,
              isPhone: true,
              prefix: "+91 "

          ),
          // const SizedBox(height: 16),

          // _buildSelectableField(
          //   label: "Relationship",
          //   value: _selectedRelation ?? "Select Relation",
          //   icon: Icons.family_restroom_outlined,
          //   onTap: () => _showCupertinoPicker(
          //     options: ['Parent', 'Spouse', 'Child', 'Sibling', 'Friend', 'Other'],
          //     title: "Relationship to You",
          //     onSelected: (val) => setState(() {
          //       _selectedRelation = val;
          //       _notifyParent();
          //     }),
          //   ),
          // ),

          const SizedBox(height: 24),
          Text("Medical Details", style: TextStyleConst.boldTextStyle(Colors.black54, 13)),
          const SizedBox(height: 12),

          // --- DOB and Age ---
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildSelectableField(
                  label: "Date of Birth",
                  value: _dobController.text.isEmpty ? "Date of Birth" : _dobController.text,
                  icon: Icons.calendar_month_outlined,
                  onTap: _showDatePicker,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (_) => _notifyParent(),
                  decoration: _inputDecoration("Age").copyWith(counterText: ""),
                  maxLength: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- Gender and Blood Group ---
          Row(
            children: [
              Expanded(
                child: _buildSelectableField(
                  label: "Gender",
                  value: _selectedGender ?? "Select",
                  icon: Icons.wc_outlined,
                  onTap: () => _showCupertinoPicker(
                    options: _genderOptions,
                    title: "Select Gender",
                    onSelected: (val) => setState(() {
                      _selectedGender = val;
                      _notifyParent();
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSelectableField(
                  label: "Blood Group",
                  value: _bloodGroupController.text.isEmpty ? "Select" : _bloodGroupController.text,
                  icon: Icons.bloodtype_outlined,
                  onTap: () => _showCupertinoPicker(
                    options: _bloodGroups,
                    title: "Select Blood Group",
                    onSelected: (val) => setState(() {
                      _bloodGroupController.text = val;
                      _notifyParent();
                    }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Helper for TextFields with Labels
  Widget _buildFieldLabel(String hint, TextEditingController controller, IconData? icon, {bool isPhone = false, String? prefix}) {
    return TextField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      inputFormatters: isPhone ? [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ] : [],
      onChanged: (_) => _notifyParent(),
      decoration: _inputDecoration(hint).copyWith(
        prefixIcon: icon != null ? Icon(icon, size: 18, color: Colors.grey) : null,
        // prefixText: prefix,
        // prefixStyle:  TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        //   fontSize: 14,
        // ),
      ),
    );
  }

// Helper for Dropdowns/Pickers
  Widget _buildSelectableField({required String label, required String value, required IconData icon, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyleConst.regularTextStyle(
                        value.contains("Select") ? Colors.grey : Colors.black87,
                        14
                    ),
                  ),
                ),
                const Icon(Icons.expand_more, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyleConst.regularTextStyle(Colors.grey, 14),
      fillColor: const Color(0xFFF8F9FA),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: ColorConst.primaryColor, width: 1)),
    );
  }
}