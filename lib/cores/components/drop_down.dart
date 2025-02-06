
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

// extends String
class DropDownWidget<T> extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.items,
    this.title,
    this.onTap,
    this.hintText,
    this.fillColor,
    this.value,
    this.titleBold = true,
    this.radius,
    this.builderChild,
    this.dropDownIcon,
  });

  const DropDownWidget.lightTitle({
    super.key,
    required this.items,
    this.title,
    this.onTap,
    this.hintText,
    this.fillColor,
    this.value,
    this.radius,
    this.builderChild,
    this.dropDownIcon,
  }) : titleBold = false;

  final List<T> items;
  final String? title;
  final String? hintText;
  final T? value;
  final Function(T? val)? onTap;
  final Color? fillColor;
  final bool titleBold;
  final Widget? dropDownIcon;
  final double? radius;
  final Widget Function(T)? builderChild;

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.items.where((e) {

      return const DeepCollectionEquality().equals(e, widget.value);
    }).firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          TextWidget(
            widget.title ?? '',
            fontSize: 14,
            textColor: context.isDarkMode
                ? AppColor.color667085
                : AppColor.color444B59,
            fontWeight: widget.titleBold ? FontWeight.w500 : FontWeight.w400,
            withOpacity: widget.titleBold ? 1 : 0.9,
          ),
        const VSpace(3),
        DropdownButtonFormField2<T?>(
          isExpanded: true,
          value: value,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: h(17)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? sr(15)),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 15),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 15),
              borderSide: const BorderSide(
                color: AppColor.kcSoftTextColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 15),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
          ),
          hint: TextWidget(
            widget.hintText ?? '',
          ),
          items: widget.items.map((item) {
            // Use key property for MapEntry
            String itemKey = item is MapEntry ? item.key : item.toString();
            return DropdownMenuItem<T>(
              key: ValueKey(itemKey), // Add unique key
              value: item,
              child: widget.builderChild?.call(item) ??
                  TextWidget(
                    item.toString(),
                  ),
            );
          }).toList(),
          onChanged: (T? value) {
            // setState(() {});
            // setState(() {
            //   selectedValue = value;
            // });
            widget.onTap?.call(value);

            // Loop through items and check for a match
            // T? match;
            // for (T item in widget.items) {
            //   if (item == value) {
            // widget.onTap?.call(value);
            //     print(true); // Find the matching item
            //     break; // Exit the loop once a match is found
            //   }
            // }

            // if (match != null) {
            //   setState(() {
            //     selectedValue =
            //         match; // Update the selected value if a match is found
            //   });
            // }
          },
          // onSaved: (newValue) {
          //   widget.onTap?.call(newValue);
          // },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: AppColor.kcSoftTextColor,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}
