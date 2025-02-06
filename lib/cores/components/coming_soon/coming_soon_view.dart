import 'package:flutter/material.dart';

import '../../navigator/navigator.dart';
import '../../utils/__utils.dart';
import '../__components.dart';

class ComingSoonPage extends StatelessWidget {
  static const String routeName = "coming_soon";

  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const HSpace(double.infinity),
          Container(
            color: Colors.grey.shade100,
            child: ImageWidget(
              imageUrl: "assets/images/intro/jumping.png",
              imageTypes: ImageTypes.asset,
              height: h(212),
              width: w(270),
            ),
          ),
          const VSpace(),
          TextWidget(
            'Recon Premium is \ncoming soon!',
            fontSize: sp(24),
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          const VSpace(20),
          Button(
            text: "Okay",
            onTap: AppRouter.instance.goBack,
          ),
        ],
      ),
    );
  }
}
