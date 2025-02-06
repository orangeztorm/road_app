import 'package:flutter/material.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';

class EnterPinWidget extends StatelessWidget {
  final Function(String)? onChanged;

  const EnterPinWidget({super.key, this.onChanged});

  static final authLocalStorage = getIt<AuthLocalStorageDataSource>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HSpace(double.infinity),
        const VSpace(),
        ImageWidget(
          imageTypes: ImageTypes.svg,
          imageUrl: "assets/images/warning_check.svg",
          width: w(72),
          height: h(72),
        ),
        const VSpace(),
        const TextWidget.bold("Enter Your PIN", fontSize: kfsVeryLarge),
        const TextWidget(
          "Please enter your PIN to send request",
          textAlign: TextAlign.center,
          withOpacity: 0.5,
        ),
        const VSpace(32),
        PinInputWidget(
          validator: (value) {
            // Implement PIN validation if needed
            if (value == null || value.length != 4) {
              return 'Please enter a valid 4-digit PIN';
            }
            return null;
          },
          length: 4,
          onChanged: (val) {
            if (val != null && val.length == 4) {
              onChanged?.call(val);
              AppRouter.instance.goBack();
            }
          },
        ),
        const VSpace(45),
        FutureBuilder<bool>(
          future: authLocalStorage.canUseThumbPrint(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              // Handle error if needed
              return const SizedBox.shrink();
            }
            if (snapshot.data == true) {
              return GestureDetector(
                onTap: () async {
                  // final authenticate =
                  //     await authLocalStorage.authenticateWithBioMetric();
                  // final hashedPin = getIt<UserProfileManager>().transactionPin;
                  // log("hashedPin $hashedPin");
                  // if (authenticate && hashedPin != null) {
                  //   onChanged?.call(hashedPin);
                  //   AppRouter.instance.goBack();
                  // } else {
                  //   Toast.useContext(
                  //     message: "Authentication Failed",
                  //     context: context,
                  //     type: SnackbarType.error,
                  //   );
                  //   log("Authentication Failed");
                  // }
                },
                child: Container(
                  padding: EdgeInsets.all(w(11)),
                  decoration: BoxDecoration(
                    color: const Color(0xffF2F3F4),
                    borderRadius: BorderRadius.circular(sr(20)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.fingerprint,
                          color: AppColor.kcPrimaryColor, size: 24),
                      HSpace(),
                      TextWidget("Tap to use biometrics", fontSize: kfsTiny),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const VSpace(40),
      ],
    );
  }
}
