import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T> onChanged;
  final T value;
  final bool isEnabled;
  CustomDropdown({
    Key key,
    @required this.dropdownMenuItemList,
    @required this.onChanged,
    @required this.value,
    this.isEnabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
              color: Color(0xFF8F9297),
              width: 1,
            ),
            // color: isEnabled ? Colors.white : Colors.grey.withAlpha(100),
            color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            // itemHeight: 50.0,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                // color: isEnabled ? Color(0xFF16191F) : Colors.grey[700],
                color: Color(0xFF16191F)),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFFAFAFAF),
            ),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            value: value,
            focusColor: Color(0xFF8F9297),
            iconEnabledColor: Color(0xFF8F9297),
          ),
        ),
      ),
    );
  }
}
