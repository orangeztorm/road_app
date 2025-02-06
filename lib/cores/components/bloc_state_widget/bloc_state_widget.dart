
// final class StateItem {
//   final bool state;
//   final Widget child;
//
//   const StateItem({required this.state, required this.child});
// }
//
// class BlocStateWidget extends StatelessWidget {
//   final StateItem loadingState;
//   final StateItem errorState;
//   final StateItem successState;
//
//   const BlocStateWidget({
//     super.key,
//     required this.loadingState,
//     required this.errorState,
//     required this.successState,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (loadingState.state) {
//       return loadingState.child;
//     } else if (errorState.state) {
//       return errorState.child;
//     } else if (successState.state) {
//       return successState.child;
//     }
//
//     return const SizedBox.shrink();
//   }
// }
