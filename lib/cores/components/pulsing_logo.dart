// import 'package:flutter/material.dart';
// import 'package:beam/cores/__cores.dart'; // Replace with your core paths

// class PulsingLogoWithShimmer extends StatefulWidget {
//   const PulsingLogoWithShimmer({super.key});

//   @override
//   _PulsingLogoWithShimmerState createState() => _PulsingLogoWithShimmerState();
// }

// class _PulsingLogoWithShimmerState extends State<PulsingLogoWithShimmer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     // Animation controller for rotating effect
//     _controller = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat(); // Continuous rotation
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center, // Align everything in the center
//       children: [
//         // Rotating and shimmering container
//         RotationTransition(
//           turns: _controller, // Rotates the container
//           child: ShimmeringContainer(), // Custom container with shimmer effect
//         ),
//         // Static logo in the center
//         ClipOval(
//           child: Container(
//             height: h(48),
//             width: w(48),
//             decoration: BoxDecoration(
//               color: AppColor.kcPrimaryColor, // Background for the logo
//             ),
//             child: ImageWidget(
//               imageTypes: ImageTypes.asset,
//               imageUrl: Images.wSLogo, // Replace with your logo
//               width: w(50),
//               height: h(50),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ShimmeringContainer extends StatefulWidget {
//   @override
//   _ShimmeringContainerState createState() => _ShimmeringContainerState();
// }

// class _ShimmeringContainerState extends State<ShimmeringContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _shimmerController;

//   @override
//   void initState() {
//     super.initState();
//     // Controller for shimmer animation
//     _shimmerController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true); // Shimmer effect goes back and forth
//   }

//   @override
//   void dispose() {
//     _shimmerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _shimmerController,
//       builder: (context, child) {
//         return ShaderMask(
//           shaderCallback: (bounds) {
//             return LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.3),
//                 Colors.white.withOpacity(0.1),
//                 Colors.white.withOpacity(0.3),
//               ],
//               stops: [
//                 _shimmerController.value - 0.3,
//                 _shimmerController.value,
//                 _shimmerController.value + 0.3,
//               ],
//             ).createShader(bounds);
//           },
//           blendMode: BlendMode.srcATop, // The shimmer effect on top
//           child: Container(
//             height: h(60),
//             width: w(60),
//             decoration: BoxDecoration(
//               color: AppColor.kcPrimaryColor, // The color of the container
//               shape: BoxShape.circle,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart'; // Replace with your core paths

class PulsingLogoWithShimmer extends StatefulWidget {
  const PulsingLogoWithShimmer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PulsingLogoWithShimmerState createState() => _PulsingLogoWithShimmerState();
}

class _PulsingLogoWithShimmerState extends State<PulsingLogoWithShimmer>
    with TickerProviderStateMixin {
  // Updated to use TickerProviderStateMixin for multiple controllers
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animation controller for rotating effect
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(); // Continuous rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Align everything in the center
      children: [
        // Rotating, shimmering, and pulsing container
        RotationTransition(
          turns: _controller, // Rotates the container
          child:
              const ShimmeringPulsingContainer(), // Custom container with shimmer and pulsing effect
        ),
        // Static logo in the center
        ClipOval(
          child: Container(
            height: h(48),
            width: w(48),
            decoration: const BoxDecoration(
              color: AppColor.kcPrimaryColor, // Background for the logo
            ),
            child: ImageWidget(
              imageTypes: ImageTypes.asset,
              imageUrl: Images.beamLogo, // Replace with your logo
              width: w(50),
              height: h(50),
            ),
          ),
        ),
      ],
    );
  }
}

class ShimmeringPulsingContainer extends StatefulWidget {
  const ShimmeringPulsingContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShimmeringPulsingContainerState createState() =>
      _ShimmeringPulsingContainerState();
}

class _ShimmeringPulsingContainerState extends State<ShimmeringPulsingContainer>
    with TickerProviderStateMixin {
  // Updated to TickerProviderStateMixin for multiple tickers
  late AnimationController _shimmerController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    // Controller for shimmer animation
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Shimmer effect goes back and forth

    // Controller for pulsing effect
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Pulsing effect goes back and forth
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.05).animate(
            CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
          ), // Adds the pulsing effect
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.4),
                ],
                stops: [
                  _shimmerController.value - 0.3,
                  _shimmerController.value,
                  _shimmerController.value + 0.3,
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop, // The shimmer effect on top
            child: Container(
              height: h(60), // Keep your original height and width
              width: w(60),
              decoration: const BoxDecoration(
                color: AppColor.kcPrimaryColor, // The color of the container
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
