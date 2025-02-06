import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';

// import 'package:lottie/lottie.dart';

class SafeAreaData {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const SafeAreaData({
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  });
}

class ScaffoldWidget extends StatelessWidget {
  ScaffoldWidget({
    super.key,
    required this.body,
    this.appBar,
    this.usePadding = true,
    this.useSingleScroll = true,
    this.extendBehindAppBar = false,
    this.useListView = false,
    this.useSafeArea = true,
    this.bg,
    this.scaffoldKey,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.scrollController,
    this.safeAreaData = const SafeAreaData(),
    this.onRefresh, // Add onRefresh callback
  });

  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? extendBehindAppBar;
  final bool? useSafeArea;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool usePadding, useListView, useSingleScroll;
  final Color? bg;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController? scrollController;
  final SafeAreaData safeAreaData;
  final Future<void> Function()? onRefresh; // Add onRefresh callback

  final LoadingOverlayBloc _loadingOverlayBloc = getIt<LoadingOverlayBloc>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
      ),
    );

    final EdgeInsets edgeInsets =
        EdgeInsets.symmetric(horizontal: usePadding ? sp(kGlobalPadding) : 0);

    return SizedBox(
      height: sh(100),
      child: BlocBuilder<LoadingOverlayBloc, LoadingOverlayState>(
        bloc: _loadingOverlayBloc,
        builder: (context, state) {
          bool showLoading = true;

          if (state is LoadingOverLayLoading) {
            showLoading = true;
          } else {
            showLoading = false;
          }

          return GestureDetector(
            onTap: () {
              // Dismiss the keyboard when tapping outside of the text fields
              FocusScope.of(context).unfocus();
            },
            child: Stack(children: [
              Scaffold(
                drawerEnableOpenDragGesture: true,
                key: scaffoldKey,
                extendBodyBehindAppBar: extendBehindAppBar ?? false,
                appBar: appBar,
                backgroundColor:
                    bg ?? Theme.of(context).scaffoldBackgroundColor,
                body: Padding(
                  padding: Platform.isAndroid
                      ? EdgeInsets.only(top: h(20))
                      : EdgeInsets.zero,
                  child: _buildBody(context, edgeInsets, useSafeArea ?? true),
                ),
                drawer: drawer,
                bottomNavigationBar: bottomNavigationBar,
                floatingActionButton: floatingActionButton,
              ),

              // Loading Widget
              Visibility(
                visible: showLoading,
                child: SizedBox.square(
                  dimension: sh(100),
                  child: Material(
                    color: Colors.grey.withOpacity(0.6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: h(150),
                          width: w(150),
                          decoration: BoxDecoration(
                            color: AppColor.kcPrimaryColor,
                            borderRadius: BorderRadius.circular(sr(10)),
                          ),
                          padding: EdgeInsets.all(w(20)),
                          child: const Column(children: [
                            Spacer(),
                            CupertinoActivityIndicator(color: Colors.white),
                            VSpace(5),
                            TextWidget("Loading...", textColor: Colors.white),
                            Spacer(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  // Widget _buildBody(
  //     BuildContext context, EdgeInsets edgeInsets, bool useSafeArea) {
  //   Widget bodyWidget;

  //   // Use RefreshIndicator if onRefresh is provided
  //   if (onRefresh != null) {
  //     bodyWidget = RefreshIndicator(
  //       onRefresh: onRefresh!,
  //       child: SingleChildScrollView(
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         controller: scrollController,
  //         child: Padding(padding: edgeInsets, child: body),
  //       ),
  //     );
  //   } else {
  //     if (useSingleScroll) {
  //       bodyWidget = SingleChildScrollView(
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         controller: scrollController,
  //         child: Padding(padding: edgeInsets, child: body),
  //       );
  //     } else {
  //       bodyWidget = Padding(padding: edgeInsets, child: body);
  //     }
  //   }

  //   // Wrap the body with SafeArea conditionally
  //   if (useSafeArea) {
  //     bodyWidget = SafeArea(
  //       top: safeAreaData.top,
  //       bottom: safeAreaData.bottom,
  //       left: safeAreaData.left,
  //       right: safeAreaData.right,
  //       child: SizedBox(height: sh(99), child: bodyWidget),
  //     );
  //   }

  //   return bodyWidget;
  // }

  Widget _buildBody(
      BuildContext context, EdgeInsets edgeInsets, bool useSafeArea) {
    Widget bodyWidget;

    // Use RefreshIndicator if onRefresh is provided
    if (onRefresh != null) {
      bodyWidget = RefreshIndicator(
        onRefresh: onRefresh!,
        child: _buildScrollableContent(edgeInsets),
      );
    } else {
      bodyWidget = _buildScrollableContent(edgeInsets);
    }

    // Wrap the body with SafeArea conditionally
    if (useSafeArea) {
      bodyWidget = SafeArea(
        top: safeAreaData.top,
        bottom: safeAreaData.bottom,
        left: safeAreaData.left,
        right: safeAreaData.right,
        child: SizedBox(height: sh(99), child: bodyWidget),
      );
    }

    return bodyWidget;
  }

  Widget _buildScrollableContent(EdgeInsets edgeInsets) {
    if (useSingleScroll) {
      // Use SingleChildScrollView when `useSingleScroll` is true
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        child: Padding(padding: edgeInsets, child: body),
      );
    } else if (useListView) {
      // Use ListView when `useListView` is true
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        children: [
          Padding(padding: edgeInsets, child: body),
        ],
      );
    } else {
      // No scrolling needed, just display the content normally (e.g., Column or SizedBox)
      return Padding(padding: edgeInsets, child: body);
    }
  }
}
