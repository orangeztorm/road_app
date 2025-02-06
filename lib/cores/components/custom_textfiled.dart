import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_app/cores/__cores.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget.password({
    super.key,
    this.controller,
    this.autoCorrect = true,
    this.inputDecoration,
    this.textAlign = TextAlign.start,
    required this.hintText,
    this.title,
    this.validator,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.initialValue,
    this.enabled = true,
    this.maxLine = 1,
    this.labelText,
    this.suffix,
    this.suffixWidget,
    this.prefix,
    this.onChanged,
    this.onSubmitted,
    this.boldHintText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.prefixText,
    this.maxlength,
    this.fillColor,
    this.radius,
    this.autofocus = false,
    this.titleBold = true,
    this.fontSize = kfsMedium,
    this.fontWeight = FontWeight.w300,
  }) : isPassword = true;

  const TextFieldWidget.greyTitle({
    super.key,
    this.controller,
    this.autoCorrect = true,
    this.inputDecoration,
    this.textAlign = TextAlign.start,
    required this.hintText,
    this.initialValue,
    this.labelText,
    this.title,
    this.validator,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.suffix,
    this.suffixWidget,
    this.prefix,
    this.onChanged,
    this.fillColor,
    this.onSubmitted,
    this.boldHintText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.prefixText,
    this.maxlength,
    this.radius,
    this.autofocus = false,
    this.fontSize = kfsMedium,
    this.fontWeight = FontWeight.w300,
  }) : titleBold = false;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.autoCorrect = true,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.inputDecoration,
    required this.hintText,
    this.title,
    this.labelText,
    this.initialValue,
    this.validator,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.suffix,
    this.suffixWidget,
    this.prefix,
    this.onChanged,
    this.onSubmitted,
    this.boldHintText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.prefixText,
    this.maxlength,
    this.titleBold = true,
    this.radius,
    this.autofocus = false,
    this.fontSize = kfsMedium,
    this.fontWeight = FontWeight.w300,
  });

  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final bool autoCorrect;
  final String hintText;
  final String? title, labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType textInputType;
  final bool isPassword;
  final bool enabled, readOnly, autofocus;
  final bool boldHintText;
  final int? maxLine, maxlength;
  final void Function()? onTap;
  final IconData? suffix;
  final String? initialValue;
  final Widget? suffixWidget;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final bool titleBold;
  final Color? fillColor;
  final double? radius;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (BuildContext context, bool value, dynamic child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              TextWidget(
                widget.title!,
                fontSize: 15,
                textColor: !context.isDarkMode
                    ? AppColor.kcTextColor
                    : AppColor.color667085,
                fontWeight:
                    widget.titleBold ? FontWeight.w700 : FontWeight.w400,
              ),
            const VSpace(7),
            TextFormField(
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLine,
              autofocus: widget.autofocus,
              readOnly: widget.readOnly,
              enabled: widget.enabled,
              textAlign: widget.textAlign,
              maxLength: widget.maxlength,
              initialValue: widget.initialValue,
              onTap: widget.onTap,
              style: GoogleFonts.karla(
                color: const Color(0xff212327),
                fontWeight: widget.fontWeight ?? FontWeight.w500,
                fontSize: sp(widget.fontSize ?? 13),
              ),
              controller: widget.controller,
              autocorrect: widget.autoCorrect,
              autovalidateMode: widget.validator != null
                  ? AutovalidateMode.onUserInteraction
                  : null,
              decoration: widget.inputDecoration ??
                  InputDecoration(
                    prefixText: widget.prefixText,
                    labelText: widget.labelText,

                    floatingLabelBehavior: FloatingLabelBehavior
                        .auto, // Label floats only when typing
                    floatingLabelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: sp(kfsTiny),
                      color: AppColor.kcSoftTextColor,
                    ),
                    counterText: '',

                    contentPadding: EdgeInsets.symmetric(
                      vertical: h(10),
                      horizontal: w(10),
                    ),
                    prefixStyle: GoogleFonts.poppins(
                      color: !context.isDarkMode
                          ? AppColor.color667085
                          : AppColor.colorA4ABBB,
                      fontWeight: FontWeight.w600,
                      fontSize: sp(widget.fontSize ?? 13),
                    ),
                    errorMaxLines: 2,
                    filled: true,
                    fillColor: widget.fillColor ??
                        AppColor.color8E96A9.withOpacity(.2),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(widget.radius ?? 16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius:
                          BorderRadius.circular(sr(widget.radius ?? 0)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColor.kcErrorColor),
                      borderRadius:
                          BorderRadius.circular(sr(widget.radius ?? 0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius:
                          BorderRadius.circular(sr(widget.radius ?? 0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius:
                          BorderRadius.circular(sr(widget.radius ?? 0)),
                    ),
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.poppins(
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                      fontSize: sp(13),
                    ),
                    prefixIcon: widget.prefix,
                    suffixIcon: _buildSuffixWidget(value),
                  ),
              keyboardType: widget.textInputType,
              cursorHeight: h(13),
              obscureText: value && widget.isPassword,
              validator: (String? val) {
                if (val == null || widget.validator == null) return null;

                return widget.validator!(val.trim());
              },
              onChanged: (String val) {
                if (widget.onChanged == null) return;

                widget.onChanged!(val.trim());
              },
              onFieldSubmitted: (String val) {
                if (widget.onSubmitted == null) return;

                widget.onSubmitted!(val.trim());
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSuffixWidget(value) {
    if (widget.suffixWidget != null) {
      return widget.suffixWidget!;
    } else if (widget.isPassword == true) {
      return suffixWidget(value);
    } else {
      if (widget.suffix != null) {
        return Icon(widget.suffix);
      } else {
        return const SizedBox();
      }
    }
  }

  IconButton suffixWidget(bool value) {
    final theme = Theme.of(context);
    if (!value) {
      return IconButton(
        icon: const Icon(CupertinoIcons.eye_slash_fill),
        color: theme.iconTheme.color,
        onPressed: () => obscureText.value = !obscureText.value,
      );
    } else {
      return IconButton(
        icon: const Icon(CupertinoIcons.eye_fill),
        color: const Color(0xFFA0AFB4),
        onPressed: () => obscureText.value = !obscureText.value,
      );
    }
  }
}

// @Deprecated('Use WalletAmountTextField instead')
class AmountTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final String currency;
  final num? maxAmount;
  final Function(String)? onChange;
  final bool enable;
  final bool showBalance;
  final TextEditingController? controller;

  const AmountTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.maxAmount,
    this.onChange,
    this.currency = "\u20A6 ",
    this.enable = true,
    this.controller,
    this.showBalance = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Opacity(
          opacity: 0.7,
          child: TextWidget(
            title,
            textColor: !context.isDarkMode
                ? AppColor.color667085
                : AppColor.colorA4ABBB,
            fontSize: sp(14),
            fontWeight: FontWeight.w400,
            // fontWeight: titleBold ? FontWeight.w500 : FontWeight.w400,
            // withOpacity: titleBold ? 1 : 0.6,
          ),
        ),
        const Spacer(),
        Visibility(
          visible: showBalance,
          child: TwoSpanTextWidget(
            "BAL: ",
            currencyFormatter(maxAmount ?? 0),
            fontSize: kfsTiny,
            fontSize2: kfsTiny,
            textColor: const Color(0xff667085),
            fontWeight: FontWeight.w400,
            fontWeight2: FontWeight.w500,
          ),
        ),
      ]),
      TextFieldWidget(
        controller: controller,
        enabled: enable,
        titleBold: false,
        hintText: hintText,
        onChanged: (val) {
          val = val
              .replaceAll(",", "")
              .replaceAll(".", "")
              .replaceAll(currency, "");

          onChange?.call(val);
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyTextInputFormatter(symbol: currency, decimalDigits: 2),
        ],
        suffixWidget: sufixWidget(),
      ),
    ]);
  }

  Widget sufixWidget() {
    return Container(
      margin: EdgeInsets.only(right: w(16)),
      padding: EdgeInsets.all(w(0)),
      child: ImageWidget(
        imageTypes: ImageTypes.svg,
        imageUrl: "assets/svg/ngn_circle.svg",
        height: h(20),
        width: w(20),
      ),
    );
  }
}

class TextFieldLabelWidget extends StatefulWidget {
  const TextFieldLabelWidget.password({
    super.key,
    this.controller,
    this.autoCorrect = true,
    required this.hintText,
    this.title,
    this.validator,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.enabled = true,
    this.maxLine = 1,
    this.labelText,
    this.suffix,
    this.suffixWidget,
    this.prefix,
    this.onChanged,
    this.onSubmitted,
    this.boldHintText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.prefixText,
    this.maxlength,
    this.radius,
    this.autofocus = false,
    this.titleBold = true,
  }) : isPassword = true;

  const TextFieldLabelWidget.greyTitle({
    super.key,
    this.controller,
    this.autoCorrect = true,
    required this.hintText,
    this.labelText,
    this.title,
    this.validator,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.suffix,
    this.suffixWidget,
    this.prefix,
    this.onChanged,
    this.onSubmitted,
    this.boldHintText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.prefixText,
    this.maxlength,
    this.radius,
    this.autofocus = false,
  }) : titleBold = false;

  const TextFieldLabelWidget({
    super.key,
    this.controller,
    this.autoCorrect = true,
    required this.hintText,
    this.title,
    this.labelText,
    this.validator,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.suffix,
    this.suffixWidget,
    this.prefix,
    this.onChanged,
    this.onSubmitted,
    this.boldHintText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.prefixText,
    this.maxlength,
    this.titleBold = true,
    this.radius,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final bool autoCorrect;
  final String hintText;
  final String? title, labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType textInputType;
  final bool isPassword;
  final bool enabled, readOnly, autofocus;
  final bool boldHintText;
  final int? maxLine, maxlength;
  final void Function()? onTap;
  final IconData? suffix;
  final Widget? suffixWidget;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final bool titleBold;
  final double? radius;

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldLabelWidgetState createState() => _TextFieldLabelWidgetState();
}

class _TextFieldLabelWidgetState extends State<TextFieldLabelWidget> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (BuildContext context, bool value, dynamic child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sr(15)),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null)
                Padding(
                  padding: EdgeInsets.only(top: h(5), left: w(20), bottom: 0),
                  child: TextWidget(
                    widget.title!,
                    fontSize: sp(10),
                    textColor: !context.isDarkMode
                        ? AppColor.color444B59
                        : AppColor.color667085,
                    fontWeight: FontWeight.w300,
                    withOpacity: widget.titleBold ? 1 : 0.9,
                  ),
                ),
              // const VSpace(5),
              TextFormField(
                inputFormatters: widget.inputFormatters,
                maxLines: widget.maxLine,
                autofocus: widget.autofocus,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                maxLength: widget.maxlength,
                onTap: widget.onTap,
                style: GoogleFonts.poppins(
                  color: !context.isDarkMode
                      ? const Color(0xff212327)
                      : AppColor.colorA4ABBB,
                  fontWeight: FontWeight.w300,
                  fontSize: sp(15),
                ),
                controller: widget.controller,
                autocorrect: widget.autoCorrect,
                autovalidateMode: widget.validator != null
                    ? AutovalidateMode.onUserInteraction
                    : null,
                decoration: InputDecoration(
                  prefixText: widget.prefixText,
                  labelText: widget.labelText,
                  contentPadding: EdgeInsets.only(
                      bottom: h(13), left: w(20), right: w(20), top: 0),
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: sp(10),
                  ),
                  counterText: '',
                  prefixStyle: GoogleFonts.poppins(
                    color: !context.isDarkMode
                        ? AppColor.color667085
                        : AppColor.colorA4ABBB,
                    fontWeight: FontWeight.w600,
                    fontSize: sp(13),
                  ),
                  errorMaxLines: 2,
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color(0xff272727).withOpacity(0.1)
                      : const Color(0xFFFFFFFF).withOpacity(0.1),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .color!
                        .withOpacity(0.3),
                    fontWeight: FontWeight.w400,
                    fontSize: sp(16),
                  ),
                  prefixIcon: widget.prefix,
                  suffixIcon: _buildSuffixWidget(value),
                ),
                keyboardType: widget.textInputType,
                obscureText: value && widget.isPassword,
                validator: (String? val) {
                  if (val == null || widget.validator == null) return null;

                  return widget.validator!(val.trim());
                },
                onChanged: (String val) {
                  if (widget.onChanged == null) return;

                  widget.onChanged!(val.trim());
                },
                onFieldSubmitted: (String val) {
                  if (widget.onSubmitted == null) return;

                  widget.onSubmitted!(val.trim());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuffixWidget(value) {
    if (widget.suffixWidget != null) {
      return widget.suffixWidget!;
    } else if (widget.isPassword == true) {
      return suffixWidget(value);
    } else {
      if (widget.suffix != null) {
        return Icon(widget.suffix);
      } else {
        return const SizedBox();
      }
    }
  }

  IconButton suffixWidget(bool value) {
    final theme = Theme.of(context);
    if (!value) {
      return IconButton(
        icon: const Icon(CupertinoIcons.eye_slash_fill),
        color: theme.iconTheme.color,
        onPressed: () => obscureText.value = !obscureText.value,
      );
    } else {
      return IconButton(
        icon: const Icon(CupertinoIcons.eye_fill),
        color: const Color(0xFFA0AFB4),
        onPressed: () => obscureText.value = !obscureText.value,
      );
    }
  }
}

class BeamAmountTextField extends StatelessWidget {
  final String currency;
  final num? maxAmount;
  final Function(String)? onChange;
  final bool enable;
  final bool showBalance;
  final TextEditingController? controller;

  const BeamAmountTextField({
    super.key,
    this.maxAmount,
    this.onChange,
    this.currency = "\u20A6 ",
    this.enable = true,
    this.controller,
    this.showBalance = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: controller,
      enabled: enable,
      titleBold: false,
      hintText: '₦0.00',
      textAlign: TextAlign.center,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      textInputType: const TextInputType.numberWithOptions(),
      onChanged: (val) {
        val = val.replaceAll(",", "").replaceAll(currency, "");

        onChange?.call(val);
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyTextInputFormatter(symbol: currency, decimalDigits: 2),
      ],
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none, // Removes the border
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: "₦0.00", // Placeholder when empty
        hintStyle: GoogleFonts.poppins(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: AppColor.kcTextColor,
        ).copyWith(
          fontFamilyFallback: [
            'NotoSansSymbols',
            'NotoSans'
          ], // Add fallbacks here
        ),
      ),
    );
  }
}

class ChatSearchTextField extends StatelessWidget {
  final String? hintText;
  final Function(String)? onChange;
  final bool enable;
  final Color fillColor;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;

  const ChatSearchTextField({
    super.key,
    this.onChange,
    this.fillColor = AppColor.colorFFF7F2,
    this.hintText,
    this.enable = true,
    this.controller,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: AppColor.kcBlack.withOpacity(.5),
          fontWeight: FontWeight.w300,
          fontSize: sp(13),
        ),
        filled: true,
        fillColor: fillColor, // Light peach background
        contentPadding: padding ??
            EdgeInsets.symmetric(
              vertical: h(10),
              horizontal: w(14),
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(sr(50))),
          borderSide: BorderSide.none, // No border line
        ),
      ),
    );
  }
}
