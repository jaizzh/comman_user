import 'package:flutter/material.dart';

/// Shared styling constants
const double _kFieldHeight = 48.0;
const double _kRadius = 12.0;
const double _kIconSize = 20.0;
const double _kGap = 14.0; // spacing between icon and text
const List<BoxShadow> _kShadow = [
  BoxShadow(spreadRadius: 1, blurRadius: 3, color: Colors.black12),
];
const TextStyle _kHintStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  color: Colors.black54,
);
const TextStyle _kTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

/// 1️⃣ TextContainer (non-editable field look)
Widget textcontainer({
  required VoidCallback? onTap,
  required IconData prefficon,
  required String hint,
//  required bool datefill,
  required String? dateee,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Card(
      elevation: 3.0,
      margin: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kRadius)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(_kRadius),
        onTap: onTap,
        child: Container(
          height: _kFieldHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: _kShadow,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: Colors.black12),
          ),
          child: dateee == null
              ? Row(
                  children: [
                    Icon(prefficon, size: _kIconSize, color: Colors.black),
                    SizedBox(width: _kGap),
                    Expanded(
                      child: Text(
                        hint,
                        style: _kHintStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Icon(prefficon, size: _kIconSize, color: Colors.black),
                    SizedBox(width: _kGap),
                    Text(
                      dateee,
                      style: _kTextStyle,
                    ),
                  ],
                ),
        ),
      ),
    ),
  );
}

/// 2️⃣ TextField (editable field, same icon alignment)
Widget textfieldd({
  required TextEditingController controller,
  required String hint,
  required int length,
  required IconData prefixicon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Card(
      elevation: 3.0,
      margin: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kRadius)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: _kFieldHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: _kShadow,
          borderRadius: BorderRadius.circular(_kRadius),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12.0),
            Icon(prefixicon, size: _kIconSize, color: Colors.black),
            SizedBox(width: _kGap),
            Expanded(
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: controller,
                maxLength: length,
                textAlignVertical: TextAlignVertical.center,
                style: _kTextStyle,
                decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  isDense: true,
                  hintText: hint,
                  hintStyle: _kHintStyle,
                  contentPadding: EdgeInsets.zero,
                ),
                cursorColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
