import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class DateFormFieldWidget extends StatefulWidget {
  final String? title;
  final String hintText;
  final Function(DateTime data) onSelect;
  final DateTime? startDate;
  final DateTime? endDate;

  const DateFormFieldWidget({
    super.key,
    this.title,
    required this.hintText,
    required this.onSelect,
    this.startDate,
    this.endDate,
  });

  @override
  State<DateFormFieldWidget> createState() => _DateFormFieldWidgetState();
}

class _DateFormFieldWidgetState extends State<DateFormFieldWidget> {
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
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.startDate ?? DateTime.now(),
          firstDate: widget.startDate ?? DateTime(1900),
          lastDate: widget.endDate ?? DateTime(2100),
        );

        if (picked != null) {
          String formattedDate = DateTimeHelper.formatDateYYMMDD(picked);
          controller.text = formattedDate;
          widget.onSelect(picked);
        }
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
            padding: EdgeInsets.all(w(8)),
            child: ImageWidget(
              // imageUrl: Assets.calender,
              imageTypes: ImageTypes.svg,
              height: h(20),
              width: w(20),
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
