import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class CommonSearchableDropDown extends StatelessWidget {
  const CommonSearchableDropDown({
    Key? key,
    this.hintText,
    this.dropButtonHeight,
    this.onChange,
    this.onSearchChanged,
    required this.searchController,
    this.color,
    this.value,
    required this.dropdownItems,
    this.isSearching = false,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> dropdownItems;
  final String? hintText;
  final double? dropButtonHeight;
  final void Function(String?)? onChange;
  final void Function(String)? onSearchChanged;
  final TextEditingController searchController;
  final Color? color;
  final String? value;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: value,
        isExpanded: true,
        onChanged: onChange,
        hint: Text(
          hintText ?? '',
          style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
        ),
        items: dropdownItems,

        // 🔹 Button Style (Main Field)
        buttonStyleData: ButtonStyleData(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffE8EAF0),
              width: 2,
            ),
          ),
        ),

        // 🔹 Icon Style
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorConst.blackColor,
          ),
        ),

        // 🔹 Dropdown Style
        dropdownStyleData: DropdownStyleData(
          maxHeight: dropButtonHeight ?? 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),

        // 🔹 SEARCH FEATURE CONFIGURATION
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
          searchInnerWidgetHeight: 65,
          searchInnerWidget: Container(
            height: 65,
            padding: const EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    onChanged: onSearchChanged, // Triggers your API search
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      hintText: 'Search patient...',
                      hintStyle: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
                      prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xffE8EAF0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: ColorConst.primaryColor),
                      ),
                    ),
                  ),
                ),
                if (isSearching)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
          searchMatchFn: (item, searchValue) {
            // Since your API is doing the filtering, we just return true here
            // to show whatever the API returns.
            return true;
          },
        ),

        // Clear the search controller when the menu closes
        onMenuStateChange: (isOpen) {
          if (isOpen) {
            // Reset the list when the menu opens to show all patients initially
            if (onSearchChanged != null && searchController.text.isEmpty) {
              onSearchChanged!('');
            }
          } else {
            // Clear only the text controller when closing, 
            // but DON'T trigger onSearchChanged!('') here to avoid 
            // overwriting filtered results if the widget is rebuilding.
            searchController.clear();
          }
        },

        style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, 16),
      ),
    );
  }
}
class CommonDropDown extends StatelessWidget {
  const CommonDropDown({
    Key? key,
    this.hintText,
    this.dropButtonHeight,
    this.onChange,
    this.errorText,
    this.onTap,
    this.enabled,
    this.color,
    this.value,
    required this.dropdownItems,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> dropdownItems;
  final String? hintText;
  final double? dropButtonHeight;
  final void Function(String?)? onChange;
  final String? errorText;
  final VoidCallback? onTap;
  final Color? color;
  final bool? enabled;
  final String? value;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: color ?? Colors.white,
//       ),
//       child: DropdownButtonFormField(
//         value: value,
//         onTap: onTap,
//         isExpanded: true,
//         style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, 16),
//         // validator: (value) => value == null ? 'Please select any code' : null,
//         menuMaxHeight: dropButtonHeight,
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,color: ColorConst.blackColor,),
//         decoration: InputDecoration(
//           enabled: enabled ?? true,
//           errorText: errorText,
//           focusedErrorBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           errorBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           border: InputBorder.none,
//           hintText: hintText,
//           hintStyle: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
//           contentPadding: enabled ?? true ? const EdgeInsets.fromLTRB(10, 30, 10, 8) : const EdgeInsets.fromLTRB(10, 20, 10, 20),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//         ),
//         items: dropdownItems,
//         onChanged: onChange,
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: value,
        isExpanded: true,
        // onTap: onTap,
        onChanged: onChange,

        hint: Text(
          hintText ?? '',
          style: TextStyleConst.hintTextStyle(
            ColorConst.hintGreyColor,
          ),
        ),

        items: dropdownItems,

        // 🔹 Button Style (Main Field)
        buttonStyleData: ButtonStyleData(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 5),

          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffE8EAF0),
              width: 2,
            ),
          ),
        ),

        // 🔹 Icon Style
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorConst.blackColor,
          ),
        ),

        // 🔹 Dropdown Style
        dropdownStyleData: DropdownStyleData(
          maxHeight: dropButtonHeight ?? 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),

        // 🔹 Menu Item Style
        menuItemStyleData: const MenuItemStyleData(
        ),

        style: TextStyleConst.mediumTextStyle(
          ColorConst.blackColor,
          16,
        ),
      ),
    );
  }}