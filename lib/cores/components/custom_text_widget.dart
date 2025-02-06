import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_app/cores/__cores.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.fontSize = kfsMedium,
    this.textColor,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.softWrap = true,
    this.overflow,
    this.decoration,
    this.height,
    this.withOpacity,
    this.fontStyle = FontStyle.normal,
  });

  const TextWidget.light(
    this.text, {
    super.key,
    this.fontSize = kfsMedium,
    this.textColor,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.softWrap = true,
    this.overflow,
    this.decoration,
    this.height = 1.5,
    this.withOpacity,
    this.fontStyle = FontStyle.normal,
  }) : fontWeight = FontWeight.w300;

  const TextWidget.bold(
    this.text, {
    super.key,
    this.fontSize = kfsMedium,
    this.textColor,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.softWrap = true,
    this.overflow,
    this.decoration,
    this.height = 1,
    this.withOpacity,
    this.fontStyle = FontStyle.normal,
  }) : fontWeight = FontWeight.w600;

  const TextWidget.semiBold(
    this.text, {
    super.key,
    this.fontSize = kfsMedium,
    this.softWrap = true,
    this.textColor,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height = 1,
    this.withOpacity,
    this.fontStyle = FontStyle.normal,
  }) : fontWeight = FontWeight.w500;

  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? height;
  final double? withOpacity;
  final FontStyle fontStyle;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.karla(
        fontSize: sp(fontSize ?? kfsMedium),
        color: (textColor ?? Theme.of(context).textTheme.titleMedium!.color)!
            .withOpacity(withOpacity ?? 1.0),
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor:
            (textColor ?? Theme.of(context).textTheme.titleMedium!.color)!
                .withOpacity(withOpacity ?? 1.0),
        height: height,
      ).copyWith(
        fontFamilyFallback: [
          'NotoSansSymbols',
          'NotoSans'
        ], // Add fallbacks here
      ),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      maxLines: maxLines,
      textScaler: const TextScaler.linear(0.95),
    );
  }
}

// class TwoSpanTextWidget extends StatelessWidget {
//   const TwoSpanTextWidget(
//     this.text,
//     this.text2, {
//     super.key,
//     this.fontSize = kfsMedium,
//     this.fontSize2 = kfsMedium,
//     this.textColor,
//     this.textColor2,
//     this.softWrap = true,
//     this.fontWeight = FontWeight.w400,
//     this.fontWeight2 = FontWeight.w400,
//     this.textAlign = TextAlign.justify,
//     this.maxLines,
//     this.overflow,
//     this.decoration,
//     this.decoration2,
//   });

//   final String text;
//   final String text2;
//   final double? fontSize;
//   final double? fontSize2;
//   final Color? textColor;
//   final Color? textColor2;
//   final FontWeight? fontWeight;
//   final FontWeight? fontWeight2;
//   final TextAlign? textAlign;
//   final int? maxLines;
//   final bool? softWrap;
//   final TextOverflow? overflow;
//   final TextDecoration? decoration;
//   final TextDecoration? decoration2;

//   @override
//   Widget build(BuildContext context) {
//     return Text.rich(
//       TextSpan(
//         text: text,
//         style: GoogleFonts.poppins(
//             fontSize: sp(fontSize ?? kfsMedium),
//             color:
//                 (textColor ?? Theme.of(context).textTheme.titleMedium!.color),
//             fontWeight: fontWeight,
//             decoration: decoration,
//             decorationColor:
//                 textColor ?? Theme.of(context).textTheme.titleMedium!.color),
//         children: <InlineSpan>[
//           TextSpan(
//             text: text2,
//             style: GoogleFonts.poppins(
//               fontSize: sp(fontSize2 ?? kfsMedium),
//               color:
//                   textColor2 ?? Theme.of(context).textTheme.titleMedium!.color,
//               fontWeight: fontWeight2,
//               decoration: decoration2,
//               decorationColor:
//                   textColor2 ?? Theme.of(context).textTheme.titleMedium!.color,
//             ),
//           )
//         ],
//       ),
//       textAlign: textAlign,
//       overflow: overflow,
//       softWrap: softWrap ?? true,
//       maxLines: maxLines,
//       // textScaleFactor: 0.8
//     );
//   }
// }

class TwoSpanTextWidget extends StatelessWidget {
  const TwoSpanTextWidget(
    this.text,
    this.text2, {
    super.key,
    this.fontSize = kfsMedium,
    this.fontSize2 = kfsMedium,
    this.textColor,
    this.textColor2,
    this.softWrap = true,
    this.fontWeight = FontWeight.w400,
    this.fontWeight2 = FontWeight.w400,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.decoration2,
    this.onTapText1, // Declare callback for text 1
    this.onTapText2, // Declare callback for text 2
  });

  final String text;
  final String text2;
  final double? fontSize;
  final double? fontSize2;
  final Color? textColor;
  final Color? textColor2;
  final FontWeight? fontWeight;
  final FontWeight? fontWeight2;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextDecoration? decoration2;
  final VoidCallback? onTapText1; // Optional callback for text 1
  final VoidCallback? onTapText2; // Optional callback for text 2

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? kfsMedium,
          color: textColor ?? Theme.of(context).textTheme.titleMedium!.color,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationColor:
              textColor ?? Theme.of(context).textTheme.titleMedium!.color,
        ),
        recognizer: onTapText1 != null
            ? (TapGestureRecognizer()
              ..onTap = onTapText1) // Corrected syntax for recognizer
            : null,
        children: <InlineSpan>[
          TextSpan(
            text: text2,
            style: GoogleFonts.poppins(
              fontSize: fontSize2 ?? kfsMedium,
              color:
                  textColor2 ?? Theme.of(context).textTheme.titleMedium!.color,
              fontWeight: fontWeight2,
              decoration: decoration2,
              decorationColor:
                  textColor2 ?? Theme.of(context).textTheme.titleMedium!.color,
            ),
            recognizer: onTapText2 != null
                ? (TapGestureRecognizer()
                  ..onTap = onTapText2) // Corrected syntax for recognizer
                : null,
          ),
        ],
      ),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap ?? true,
      maxLines: maxLines,
    );
  }
}
