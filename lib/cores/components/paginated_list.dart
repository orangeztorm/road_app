import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:road_app/cores/__cores.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ReusablePaginatedList<T> extends StatefulWidget {
  final List<T> dataList;
  final List<T> loadingList;
  final Widget Function(T item) itemBuilder;
  final Widget? seperatorWidget;
  final bool isLoading;
  final bool isLoadMore;
  final bool isFailure;
  final Failures? failure;
  final bool hasMore;
  final VoidCallback onInitialLoad;
  final VoidCallback onRetry;
  final VoidCallback? onLoadMore;
  final ScrollController? controller;
  final Widget? emptyWidget;

  const ReusablePaginatedList({
    super.key,
    required this.dataList,
    required this.loadingList,
    required this.itemBuilder,
    required this.isLoading,
    required this.isLoadMore,
    required this.isFailure,
    required this.hasMore,
    required this.onRetry,
    required this.onInitialLoad,
    this.failure,
    this.seperatorWidget,
    this.onLoadMore,
    this.controller,
    this.emptyWidget,
  });

  @override
  State<ReusablePaginatedList<T>> createState() =>
      _ReusablePaginatedListState<T>();
}

class _ReusablePaginatedListState<T> extends State<ReusablePaginatedList<T>> {
  late final ScrollController _scrollController;
  bool _isUsingExternalController = false;

  @override
  void initState() {
    super.initState();
    widget.onInitialLoad();
    _isUsingExternalController = widget.controller != null;
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients ||
        widget.onLoadMore == null ||
        widget.hasMore == false) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    const delta = 200.0;

    if (maxScroll - currentScroll <= delta &&
        !widget.isLoadMore &&
        widget.hasMore) {
      widget.onLoadMore!();
    }
  }

  @override
  void dispose() {
    if (!_isUsingExternalController) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.dataList.isEmpty) {
      return Skeletonizer(
        enabled: true,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.loadingList.length,
          itemBuilder: (_, index) =>
              widget.itemBuilder(widget.loadingList[index]),
          separatorBuilder: (_, __) =>
              widget.seperatorWidget ??
              const Padding(
                padding: EdgeInsets.only(top: 13, bottom: 16),
                child: Divider(color: AppColor.colorEBEBEB),
              ),
        ),
      );
    }

    if (widget.isFailure && widget.dataList.isEmpty) {
      return CustomErrorWidget(
        message: widget.failure?.message ?? AppStrings.somethingWentWrong,
        useFlex: false,
        callback: widget.onRetry,
      );
    }

    if (widget.dataList.isEmpty) {
      return widget.emptyWidget ?? const TextWidget('No Data Found');
    }

    return ListView.separated(
      controller: _scrollController,
      itemCount: widget.dataList.length + 1,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index < widget.dataList.length) {
          return widget
              .itemBuilder(widget.dataList[index])
              .animate()
              .fade(duration: 300.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOut);
        } else {
          if (widget.isLoadMore) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(child: LoadingIndicatorWidget()),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: TextWidget(
                  widget.hasMore ? 'Pull To Load More' : 'No More Data',
                  fontSize: 10,
                  textColor: AppColor.kcGrey800,
                ),
              ),
            );
          }
        }
      },
      separatorBuilder: (_, __) =>
          widget.seperatorWidget ?? const SizedBox(height: 16),
    );
  }
}
