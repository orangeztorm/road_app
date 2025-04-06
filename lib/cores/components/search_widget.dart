import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/data/responses/admin/places_response.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(SearchFieldListItem<dynamic>?) submitAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final List<SuggestedPlacesPrediction> list;
  final bool loading;

  const SearchWidget(
      {super.key,
      required this.controller,
      required this.submitAction,
      this.prefixIcon,
      this.loading = false,
      this.hintText,
      this.list = const [],
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return SearchField(
      searchBoxHeight: h(60),
      controller: controller,
      emptyWidget: Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: AppColor.kcWhite,
            boxShadow: [
              BoxShadow(
                color: AppColor.kcTextColor.withOpacity(0.05),
                blurRadius: 40,
                offset: const Offset(
                  0,
                  4,
                ),
              )
            ],
          ),
          child: const Center(
            child: TextWidget.semiBold(
              'No Address Found',
              fontSize: kfsVeryTiny,
              textColor: AppColor.kcGrey600,
            ),
          )),
      loadingWidget: Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: AppColor.kcWhite,
            boxShadow: [
              BoxShadow(
                color: AppColor.kcTextColor.withOpacity(0.05),
                blurRadius: 40,
                offset: const Offset(
                  0, // Move to right 0  horizontally
                  4, // Move to bottom 4 Vertically
                ),
              )
            ],
          ),
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          )),
      loading: loading,
      suggestions: (list != [])
          ? list
              .map(
                (SuggestedPlacesPrediction e) => SearchFieldListItem(
                  e.description,
                  item: e,
                  child: SearchTile(
                    data: e.description,
                  ),
                ),
              )
              .toList()
          : [],
      suggestionsDecoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColor.kcTextColor.withOpacity(0.05),
          blurRadius: 40,
          offset: const Offset(
            0, // Move to right 0  horizontally
            4, // Move to bottom 4 Vertically
          ),
        )
      ], color: AppColor.kcWhite, borderRadius: BorderRadius.circular(14)),
      marginColor: Colors.transparent,
      textInputAction: TextInputAction.next,
      onSuggestionTap: (dynamic e) async {
        final item = e as SearchFieldListItem<SuggestedPlacesPrediction>;
        final placeId = item.item?.placeId;
        final placeDetails = await getPlaceDetails(placeId ?? AppStrings.na);
        submitAction(
          placeDetails?.result?.formattedAddress != null
              ? SearchFieldListItem(
                  placeDetails?.result?.formattedAddress ?? AppStrings.na,
                  item: placeDetails,
                )
              : null,
        );
      },
      hint: hintText,
      hasOverlay: false,
      searchStyle: const TextStyle(
        fontSize: kfsMedium,
        color: AppColor.kcTextColor,
      ),
      // validator: (x) {
      //   // if (!_statesOfIndia.contains(x) || x!.isEmpty) {
      //   //  return 'Please Enter a valid State';
      //   // }
      //   return null;
      // },
      searchInputDecoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        fillColor: AppColor.kcWhite,
        hintStyle: const TextStyle(
          color: AppColor.kcGrey600,
          fontSize: kfsTiny,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconConstraints: BoxConstraints.tight(const Size(38, 20)),
        suffixIconConstraints: BoxConstraints.tight(const Size(40, 20)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.kcPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.kcPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.kcPrimaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.kcPrimaryColor),
        ),
      ),
      maxSuggestionsInViewPort: 6,
      itemHeight: 45,
      // onTap: (x) {},
    );
  }

  Future<PlaceDetailResult?> getPlaceDetails(String placeId) async {
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AppConstants.googleApiKey}');
    debugPrint('url: $url');
    final response = await http.get(url);
    log(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      final result = PlaceDetailResult.fromJson(data);
      return result;
    } else {
      throw const HttpException('Failed to load autocomplete data');
    }
  }
}

class SearchTile extends StatelessWidget {
  final String? data;
  const SearchTile({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontSize: kfsVeryTiny,
        fontWeight: FontWeight.w400,
        color: AppColor.kcGrey600,
      ),
    );
  }
}

class PlaceSearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final void Function(SearchFieldListItem<dynamic>?) submitAction;
  final bool usePrefix;
  final bool useSuffix;
  final Widget? iconSuffix;

  const PlaceSearchWidget({
    super.key,
    required this.controller,
    required this.submitAction,
    this.usePrefix = false,
    this.useSuffix = false,
    this.iconSuffix,
  });

  @override
  State<PlaceSearchWidget> createState() => _PlaceSearchWidgetState();
}

class _PlaceSearchWidgetState extends State<PlaceSearchWidget> {
  // final places = GoogleMapsPlaces(apiKey: AppConstants.googleApiKey);

  List<SuggestedPlacesPrediction> placesResponse = [];

  bool isSearching = false;
  StreamController<bool> searchLoadingStreamListener = StreamController<bool>();
  late TextEditingController _controller;
  Timer? _debounce; // Add a Timer variable for debouncing

  @override
  void initState() {
    _controller = widget.controller;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(() {
        _onSearchChanged(
            _controller.text); // Use a new method for debounced changes
      });
    });
    searchLoadingStreamListener.stream.listen((event) {
      setState(() {
        isSearching = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel(); //
    searchLoadingStreamListener.close();
    super.dispose();
  }

  Future<void> search() async {
    try {
      setState(() => isSearching = true);
      SuggestedPlacesResult response =
          await placeAutoComplete(_controller.text);
      debugPrint('response: $response');
      placesResponse = response.predictions;
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
    } finally {
      setState(() => isSearching = false);
    }
  }

  Future<SuggestedPlacesResult> placeAutoComplete(String query) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(query)}&key=${AppConstants.googleApiKey}');
    debugPrint('url: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SuggestedPlacesResult.fromJson(data);
    } else {
      throw const HttpException('Failed to load autocomplete data');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel(); // Cancel any existing timer
    }
    _debounce = Timer(const Duration(seconds: 1), () {
      if (query.length >= 5) {
        // Check if the query length is at least 5 characters
        search();
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      suffixIcon: !widget.useSuffix
          ? null
          : Visibility(
              visible: _controller.text.isNotEmpty,
              child: widget.iconSuffix ??
                  const ImageWidget(
                    imageTypes: ImageTypes.svg,
                    imageUrl: '',
                    height: 20,
                    width: 20,
                  ),
            ),
      prefixIcon: !widget.usePrefix
          ? null
          : const SizedBox(
              width: 10,
              height: 16,
              child: Icon(
                Icons.search_sharp,
                size: 16,
                color: AppColor.kcGrey600,
              ),
            ),
      hintText: 'Enter Address',
      list: placesResponse,
      loading: isSearching,
      controller: _controller,
      submitAction: (dynamic e) {
        setState(() {
          placesResponse = [];
        });
        widget.submitAction(e);
      },
    );
  }
}

class SearchFieldListItem<T> {
  Key? key;
  final String searchKey;

  final T? item;
  final Widget? child;

  SearchFieldListItem(this.searchKey, {this.child, this.item, this.key});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SearchFieldListItem &&
            runtimeType == other.runtimeType &&
            searchKey == other.searchKey;
  }

  @override
  int get hashCode => searchKey.hashCode;
}

extension ListContainsObject<T> on List {
  bool containsObject(T object) {
    for (var item in this) {
      if (object == item) {
        return true;
      }
    }
    return false;
  }
}

class SearchField<T> extends StatefulWidget {
  final FocusNode? focusNode;
  final List suggestions;

  final Function(SearchFieldListItem<T>)? onSuggestionTap;
  final Function(String)? onSubmit;
  final String? hint;
  final TextInputAction? textInputAction;
  final SearchFieldListItem<T>? initialValue;
  final TextStyle? searchStyle;
  final InputDecoration? searchInputDecoration;
  final Suggestion suggestionState;
  final SuggestionAction? suggestionAction;
  final BoxDecoration? suggestionsDecoration;
  final BoxDecoration? suggestionItemDecoration;
  final double itemHeight;
  final Color? marginColor;
  final int maxSuggestionsInViewPort;

  final TextEditingController? controller;

  final TextInputType? inputType;

  final String? Function(String?)? validator;

  final bool hasOverlay;

  final Widget emptyWidget;

  final double? searchBoxHeight;

  final bool loading;
  final Widget? loadingWidget;

  SearchField(
      {super.key,
      required this.suggestions,
      this.initialValue,
      this.focusNode,
      this.hint,
      this.hasOverlay = true,
      this.searchStyle,
      this.marginColor,
      this.controller,
      this.onSubmit,
      this.inputType,
      this.validator,
      this.suggestionState = Suggestion.expand,
      this.itemHeight = 35.0,
      this.suggestionsDecoration,
      this.searchInputDecoration,
      this.suggestionItemDecoration,
      this.maxSuggestionsInViewPort = 5,
      this.onSuggestionTap,
      this.emptyWidget = const SizedBox.shrink(),
      this.loading = false,
      this.loadingWidget,
      this.textInputAction,
      this.suggestionAction,
      this.searchBoxHeight})
      : assert(
            (initialValue != null &&
                    suggestions.containsObject(initialValue)) ||
                initialValue == null,
            'Initial value should either be null or should be present in suggestions list.');

  @override
  // ignore: library_private_types_in_public_api
  _SearchFieldState<T> createState() => _SearchFieldState<T>();
}

class _SearchFieldState<T> extends State<SearchField<T>> {
  final StreamController<List?> suggestionStream =
      StreamController<List?>.broadcast();
  FocusNode? _focus;
  bool isSuggestionExpanded = false;
  TextEditingController? searchController;

  @override
  void dispose() {
    suggestionStream.close();
    if (widget.controller == null) {
      searchController!.dispose();
    }
    if (widget.focusNode == null) {
      _focus!.dispose();
    }
    super.dispose();
  }

  void initialize() {
    if (widget.focusNode != null) {
      _focus = widget.focusNode;
    } else {
      _focus = FocusNode();
    }
    _focus!.addListener(() {
      if (mounted) {
        setState(() {
          isSuggestionExpanded = _focus!.hasFocus;
        });
      }
      if (widget.hasOverlay) {
        if (isSuggestionExpanded) {
          if (widget.initialValue == null) {
            if (widget.suggestionState == Suggestion.expand) {
              Future.delayed(const Duration(milliseconds: 100), () {
                suggestionStream.sink.add(widget.suggestions);
              });
            }
          }
          _overlayEntry = _createOverlay();
          Overlay.of(context).insert(_overlayEntry);
        } else {
          _overlayEntry.remove();
        }
      } else if (isSuggestionExpanded) {
        if (widget.initialValue == null) {
          if (widget.suggestionState == Suggestion.expand) {
            Future.delayed(const Duration(milliseconds: 100), () {
              suggestionStream.sink.add(widget.suggestions);
            });
          }
        }
      }
    });
  }

  late OverlayEntry _overlayEntry;
  @override
  void initState() {
    super.initState();
    searchController = widget.controller ?? TextEditingController();
    initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialValue == null ||
          widget.initialValue!.searchKey.isEmpty) {
        suggestionStream.sink.add(null);
      } else {
        searchController!.text = widget.initialValue!.searchKey;
        suggestionStream.sink.add([widget.initialValue]);
      }
      suggestionStream.sink.add(widget.suggestions);
    });
  }

  @override
  void didUpdateWidget(covariant SearchField<T> oldWidget) {
    if (oldWidget.controller != widget.controller) {
      searchController = widget.controller ?? TextEditingController();
    }
    if (oldWidget.hasOverlay != widget.hasOverlay) {
      if (widget.hasOverlay) {
        initialize();
      } else {
        if (_overlayEntry.mounted) {
          _overlayEntry.remove();
        }
      }
      if (mounted) {
        setState(() {});
      }
    }
    suggestionStream.sink.add(widget.suggestions);
    super.didUpdateWidget(oldWidget);
  }

  Widget _suggestionsBuilder() {
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    return StreamBuilder<List?>(
      stream: suggestionStream.stream,
      builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
        if ((snapshot.data == null || !isSuggestionExpanded) &&
            !widget.loading) {
          return const SizedBox();
        } else if (widget.loading && widget.loadingWidget != null) {
          return widget.loadingWidget!;
        } else if (snapshot.data!.isEmpty) {
          return widget.emptyWidget;
        } else {
          if (snapshot.data!.length > widget.maxSuggestionsInViewPort) {
            height = widget.itemHeight * widget.maxSuggestionsInViewPort;
          } else if (snapshot.data!.length == 1) {
            height = widget.itemHeight;
          } else {
            height = snapshot.data!.length * widget.itemHeight;
          }
          return AnimatedContainer(
            duration: isUp ? Duration.zero : const Duration(milliseconds: 300),
            height: height,
            alignment: Alignment.centerLeft,
            decoration: widget.suggestionsDecoration ??
                BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: onSurfaceColor.withOpacity(0.1),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                      offset: widget.hasOverlay
                          ? const Offset(
                              2.0,
                              5.0,
                            )
                          : const Offset(1.0, 0.5),
                    ),
                  ],
                ),
            child: ListView.builder(
              reverse: isUp,
              padding: EdgeInsets.zero,
              itemCount: snapshot.data!.length,
              physics: snapshot.data!.length == 1
                  ? const NeverScrollableScrollPhysics()
                  : const ScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  searchController!.text = snapshot.data![index]!.searchKey;
                  searchController!.selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: searchController!.text.length,
                    ),
                  );

                  // suggestion action to switch focus to next focus node
                  if (widget.suggestionAction != null) {
                    if (widget.suggestionAction == SuggestionAction.next) {
                      _focus!.nextFocus();
                    } else if (widget.suggestionAction ==
                        SuggestionAction.unfocus) {
                      _focus!.unfocus();
                    }
                  }

                  // hide the suggestions
                  suggestionStream.sink.add(null);
                  if (widget.onSuggestionTap != null) {
                    widget.onSuggestionTap!(snapshot.data![index]!);
                  }
                },
                child: Container(
                    height: widget.itemHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 5) +
                        const EdgeInsets.only(left: 8),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: widget.suggestionItemDecoration?.copyWith(
                          border: widget.suggestionItemDecoration?.border ??
                              Border(
                                bottom: BorderSide(
                                  color: widget.marginColor ??
                                      onSurfaceColor.withOpacity(0.1),
                                ),
                              ),
                        ) ??
                        BoxDecoration(
                          border: index == snapshot.data!.length - 1
                              ? null
                              : Border(
                                  bottom: BorderSide(
                                    color: widget.marginColor ??
                                        onSurfaceColor.withOpacity(0.1),
                                  ),
                                ),
                        ),
                    child: snapshot.data![index]!.child ??
                        Text(
                          snapshot.data![index]!.searchKey,
                        )),
              ),
            ),
          );
        }
      },
    );
  }

  Offset getYOffset(Offset widgetOffset, int resultCount) {
    final size = MediaQuery.of(context).size;
    final position = widgetOffset.dy;
    if ((position + height) < (size.height - widget.itemHeight * 2)) {
      return Offset(0, widget.itemHeight + 10.0);
    } else {
      if (resultCount > widget.maxSuggestionsInViewPort) {
        isUp = false;
        return Offset(
            0, -(widget.itemHeight * widget.maxSuggestionsInViewPort));
      } else {
        isUp = true;
        return Offset(0, -(widget.itemHeight * resultCount));
      }
    }
  }

  OverlayEntry _createOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (context) => StreamBuilder<List?>(
            stream: suggestionStream.stream,
            builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
              late var count = widget.maxSuggestionsInViewPort;
              if (snapshot.data != null) {
                count = snapshot.data!.length;
              }
              return Positioned(
                left: offset.dx,
                width: size.width,
                child: CompositedTransformFollower(
                    offset: getYOffset(offset, count),
                    link: _layerLink,
                    child: Material(child: _suggestionsBuilder())),
              );
            }));
  }

  final LayerLink _layerLink = LayerLink();
  late double height;
  bool isUp = false;

  @override
  Widget build(BuildContext context) {
    if (widget.suggestions.length > widget.maxSuggestionsInViewPort) {
      height = widget.itemHeight * widget.maxSuggestionsInViewPort;
    } else {
      height = widget.suggestions.length * widget.itemHeight;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.searchBoxHeight,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: TextFormField(
              onFieldSubmitted: (x) => widget.onSubmit!(x),
              onTap: () {
                /// only call if SuggestionState = [Suggestion.expand]
                if (!isSuggestionExpanded &&
                    widget.suggestionState == Suggestion.expand) {
                  suggestionStream.sink.add(widget.suggestions);
                  if (mounted) {
                    setState(() {
                      isSuggestionExpanded = true;
                    });
                  }
                }
              },
              controller: widget.controller ?? searchController,
              focusNode: _focus,
              validator: widget.validator,
              style: widget.searchStyle,
              textInputAction: widget.textInputAction,
              keyboardType: widget.inputType,
              decoration: widget.searchInputDecoration
                      ?.copyWith(hintText: widget.hint) ??
                  InputDecoration(hintText: widget.hint),
              onChanged: (query) {
                final searchResult = <SearchFieldListItem<T>>[];
                if (query.isEmpty) {
                  suggestionStream.sink.add(widget.suggestions);
                  return;
                }
                for (final suggestion in widget.suggestions) {
                  if (suggestion.searchKey
                      .toLowerCase()
                      .contains(query.toLowerCase())) {
                    searchResult.add(suggestion);
                  }
                }
                suggestionStream.sink.add(searchResult);
              },
            ),
          ),
        ),
        if (!widget.hasOverlay)
          const SizedBox(
            height: 2,
          ),
        if (!widget.hasOverlay) _suggestionsBuilder()
      ],
    );
  }
}
