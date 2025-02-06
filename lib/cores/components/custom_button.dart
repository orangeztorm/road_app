// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.onTap,
    this.errortap,
    this.color,
    this.widget,
    this.textColor,
    this.textSize = kfsLarge,
    this.height,
    this.width,
    this.textFontWeight = FontWeight.w600,
    this.circular = false,
    this.active = true,
    this.radius,
  })  : busy = false,
        iconData = null,
        borderColor = null,
        iconSize = null,
        iconColor = null;

  const Button.withBorderLine({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.transparent,
    this.borderColor = AppColor.kcTextColor,
    this.textColor = AppColor.kcTextColor,
    this.textSize = kfsLarge,
    this.errortap,
    this.height,
    this.radius,
    this.widget,
    this.width,
    this.textFontWeight = FontWeight.w400,
    this.circular = false,
    this.active = true,
    this.iconData,
    this.iconColor,
  })  : busy = false,
        iconSize = null;

  const Button.loading({
    Key? key,
    this.onTap,
    this.color,
    this.height,
    this.radius,
    this.widget,
    this.textFontWeight = FontWeight.w300,
    this.width,
    this.text,
  })  : busy = true,
        iconData = null,
        textColor = null,
        textSize = kfsMedium,
        iconSize = null,
        iconColor = null,
        borderColor = null,
        active = true,
        errortap = null,
        circular = false;

  const Button.smallSized({
    Key? key,
    this.text,
    this.onTap,
    this.radius,
    this.errortap,
    this.color,
    this.textColor,
    this.textSize = kfsLarge,
    this.height,
    this.width,
    this.widget,
    this.textFontWeight,
    this.circular = false,
    this.active = true,
  })  : busy = false,
        iconData = null,
        iconSize = null,
        borderColor = null,
        iconColor = null;

  const Button.icon({
    Key? key,
    this.text,
    this.iconData = Icons.arrow_forward,
    this.radius,
    this.height,
    this.errortap,
    this.width,
    this.onTap,
    this.widget,
    this.textSize = kfsLarge,
    this.textColor,
    this.color,
    this.iconColor,
    this.iconSize,
    this.textFontWeight,
    this.circular = false,
    this.active = true,
  })  : busy = false,
        borderColor = null;

  final String? text;
  final Widget? widget;
  final IconData? iconData;
  final void Function()? onTap;
  final void Function()? errortap;
  final bool busy;
  final bool active;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final double? height;
  final double? width;
  final FontWeight? textFontWeight;
  final Color? iconColor;
  final double? iconSize;
  final double? radius;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double defaultHeight = 46.0;
    final double defaultWidth = MediaQuery.of(context).size.width * 0.95;

    return SizedBox(
      height: sp(height ?? defaultHeight),
      width: sp(width ?? defaultWidth),
      child: TextButton(
        key: key,
        onPressed: () {
          if (active == false) {
            errortap?.call();
            return;
          }

          onTap!();
        },
        style: getButtonStyle(theme),
        child: getButtonChild(),
      ),
    );
  }

  ButtonStyle getButtonStyle(ThemeData theme) {
    WidgetStateProperty<RoundedRectangleBorder> shape;

    if (circular) {
      shape = WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sr(radius ?? 100.0)),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      );
    } else {
      shape = WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sr(radius ?? 00.0)),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      );
    }

    WidgetStateProperty<Color> backgroundColor;
    if (busy) {
      backgroundColor =
          WidgetStateProperty.all(theme.primaryColor.withOpacity(0.5));
    } else if (active == false) {
      backgroundColor =
          WidgetStateProperty.all(theme.primaryColor.withOpacity(0.5));
    } else {
      backgroundColor = WidgetStateProperty.all(
        color ?? theme.buttonTheme.colorScheme?.secondary ?? Colors.transparent,
      );
    }

    return ButtonStyle(
      shape: shape,
      backgroundColor: backgroundColor,
    );
  }

  Widget getButtonChild() {
    if (busy) {
      return Row(
        mainAxisAlignment: text == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          if (text != null)
            TextWidget(
              text ?? 'no text',
              textColor: textColor ?? AppColor.kcTextColor,
              fontSize: 18,
              fontWeight: textFontWeight ?? FontWeight.w800,
            ),
          if (text != null) const SizedBox(width: 8),
          const LoadingIndicatorWidget(),
        ],
      );
    }

    if (text != null && (iconData != null || widget != null)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (iconData != null && widget == null)
            Icon(
              iconData,
              color: iconColor ?? AppColor.kcBlack,
              size: iconSize ?? 20.0,
            ),
          if (widget != null) widget!,
          TextWidget(
            text ?? 'no text',
            textColor: textColor ?? AppColor.kcBlack,
            fontSize: textSize,
            fontWeight: textFontWeight ?? FontWeight.w800,
          ),
          const SizedBox(width: 8),
        ],
      );
    }

    if (text != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            text ?? 'no text',
            textColor: textColor ?? AppColor.kcBlack,
            fontSize: textSize,
            fontWeight: textFontWeight ?? FontWeight.w800,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Icon(
      iconData,
      color: iconColor ?? Colors.white,
      size: iconSize ?? 20.0,
    );
  }
}
