import 'package:flutter/material.dart';

import '../../cores/components/custom_text_widget.dart';
import '../../cores/components/retry_button.dart';
import '../utils/sizer_utils.dart';
import 'image_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
    this.callback,
    this.assetPath,
    this.useFlex = true,
    this.showButton = true,
    this.textColor,
  });

  final String message;
  final String? assetPath;
  final bool useFlex;
  final bool showButton;
  final void Function()? callback;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    if (useFlex) {
      return Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const HSpace(double.infinity),
            if (assetPath != null)
              SizedBox(
                height: sp(200),
                width: sp(200),
                child: ImageWidget(
                  imageTypes: ImageTypes.asset,
                  imageUrl: assetPath!,
                ),
              ),
            SizedBox(
              width: sw(70),
              child: TextWidget(
                message,
                textAlign: TextAlign.center,
                fontSize: sp(18),
                textColor: textColor,
              ),
            ),
            const SizedBox(height: 10.0),
            Visibility(
              visible: showButton,
              child: RetryButtonWidget(
                textColor: textColor,
                callback: callback?.call,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const HSpace(double.infinity),
        if (assetPath != null)
          SizedBox(
            height: sp(200),
            width: sp(200),
            child:
                ImageWidget(imageTypes: ImageTypes.asset, imageUrl: assetPath!),
          ),
        SizedBox(
          width: sw(70),
          child: TextWidget(
            message,
            textAlign: TextAlign.center,
            fontSize: sp(18),
            textColor: textColor,
          ),
        ),
        const SizedBox(height: 10.0),
        if (showButton)
          RetryButtonWidget(
            callback: callback?.call,
            textColor: textColor,
          ),
      ],
    );
  }
}
