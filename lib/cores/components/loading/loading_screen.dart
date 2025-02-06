import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    // final _text = StreamController<String>();
    // _text.add(text);

    final state = Overlay.of(context);
    // final renderBox = context.findRenderObject() as RenderBox;
    // final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return const PulsingLogoWithShimmer();
        // Material(
        //   color: Colors.black.withAlpha(150),
        //   child: Center(
        //     child: Container(
        //       constraints: BoxConstraints(
        //         maxWidth: 0.8.sw,
        //         maxHeight: 0.8.sh,
        //         minWidth: 0.5.sw,
        //       ),
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(10.0),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: SingleChildScrollView(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const SizedBox(height: 10),
        //               const CircularProgressIndicator(
        //                 color: AppColor.kcPrimaryColor,
        //               ),
        //               const SizedBox(height: 20),
        //               StreamBuilder(
        //                 stream: _text.stream,
        //                 builder: (context, snapshot) {
        //                   if (snapshot.hasData) {
        //                     return Text(
        //                       snapshot.data as String,
        //                       textAlign: TextAlign.center,
        //                       style: const TextStyle(
        //                         fontSize: 16,
        //                         fontWeight: FontWeight.w500,
        //                         color: Colors.black,
        //                       ),
        //                     );
        //                   } else {
        //                     return Container();
        //                   }
        //                 },
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        // _text.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        // _text.add(text);
        return true;
      },
    );
  }
}
