import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class CountryPickerTextField extends StatefulWidget {
  final String? title;
  final String hintText;
  final Function(Country value) onChange;
  const CountryPickerTextField({
    super.key,
    this.title,
    required this.hintText,
    required this.onChange,
  });

  @override
  State<CountryPickerTextField> createState() => _CountryPickerTextFieldState();
}

class _CountryPickerTextFieldState extends State<CountryPickerTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showCountryPicker(
          context: context,
          showPhoneCode:
              true, // optional. Shows phone code before the country name.
          onSelect: (Country country) {
            controller.text = country.name;
            widget.onChange(country);
          },
        );
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextFieldWidget(
          controller: controller,
          title: widget.title,
          hintText: widget.hintText,
          titleBold: false,
          suffixWidget: Container(
            // padding: EdgeInsets.only(left: w(10)),
            padding: EdgeInsets.all(w(12)),
            child: ImageWidget(
              // imageUrl: Assets.dropDownWidgetSvg,
              imageTypes: ImageTypes.svg,
              height: h(18),
              width: w(18),
              fit: BoxFit.fill,
              useIconColor: true,
              color: context.isDarkMode
                  ? AppColor.kcWhite
                  : AppColor.kcPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
