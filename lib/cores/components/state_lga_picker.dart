// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_function_literals_in_foreach_calls, library_private_types_in_public_api, must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_app/cores/__cores.dart';

class StateCityPicker extends StatefulWidget {
  TextEditingController state;
  TextEditingController city;
  TextEditingController country;
  InputBorder? textFieldInputBorder;
  String? lgaHeader;
  TextEditingController? countryCode;
  final bool isCountryFixed;

  StateCityPicker({
    super.key,
    required this.state,
    required this.city,
    required this.country,
    this.lgaHeader,
    this.textFieldInputBorder,
    this.countryCode,
    this.isCountryFixed = false,
  });

  @override
  _StateCityPickerState createState() => _StateCityPickerState();
}

class _StateCityPickerState extends State<StateCityPicker> {
  late final List<StateLgaModel> _stateList = [];
  late List<String> _cityList = [];

  List<StateLgaModel> _stateSubList = [];
  List<String> _citySubList = [];
  String _title = '';

  @override
  void initState() {
    super.initState();
    _getState();
  }

  Future<void> _getState() async {
    // Clear existing lists
    _stateList.clear();
    _cityList.clear();

    // Load and parse the JSON file
    var jsonString = await rootBundle.loadString('assets/state_and_lga.json');
    List<dynamic> jsonList = json.decode(jsonString);

    // Convert JSON to a list of StateLgaModel
    List<StateLgaModel> stateList =
        jsonList.map((data) => StateLgaModel.fromJson(data)).toList();

    // Add states to _stateList
    setState(() {
      _stateList.addAll(stateList);
      _stateSubList = List.from(_stateList); // Backup the state list
    });
  }

  Future<void> _getCity(List<String>? cities) async {
    setState(() {
      _cityList.clear();

      _cityList = cities ?? [];
      _citySubList = cities ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Country TextField
        ///if (widget.state != null)
        IgnorePointer(
          child: TextFieldWidget(
            controller: widget.country,
            validator: null,
            hintText: 'Select Country',
            readOnly: true,
            onTap: () {
              setState(() => _title = 'Country');
              _showDialog(context);
            },
            suffixWidget: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ),
        ),
        const VSpace(16),

        ///State TextField
        if (widget.state != null)
          TextFieldWidget(
            controller: widget.state,
            validator: null,
            hintText: 'Select State',
            readOnly: true,
            onTap: () {
              setState(() => _title = 'State');
              _showDialog(context);
            },
            suffixWidget: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ),
        const VSpace(16),
        if (widget.city != null)
          TextFieldWidget(
            controller: widget.city,
            validator: null,
            hintText: 'Select LGA',
            onTap: () {
              setState(() => _title = 'LGA');
              if (widget.state.text.isNotEmpty) {
                _showDialog(context);
              } else {
                Toast.showError('Please select state first');
              }
            },
            readOnly: _cityList.isEmpty ? false : true,
            suffixWidget: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller2 = TextEditingController();

    final theme = Theme.of(context);
    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        _title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ///Text Field
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: TextField(
                          controller: _title == 'State'
                              ? controller
                              : _title == 'LGA'
                                  ? controller2
                                  : null,
                          onChanged: (val) {
                            setState(() {
                              if (_title == 'State') {
                                _stateSubList = _stateList
                                    .where((element) => element.state
                                        .toLowerCase()
                                        .contains(
                                            controller.text.toLowerCase()))
                                    .toList();
                              } else if (_title == 'LGA') {
                                _citySubList = _cityList
                                    .where((element) => element
                                        .toLowerCase()
                                        .contains(
                                            controller2.text.toLowerCase()))
                                    .toList();
                              }
                            });
                          },
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Search here...",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              isDense: true,
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),

                      ///Dropdown Items
                      Expanded(
                        child: ListView.builder(
                          itemCount: _title == 'State'
                              ? _stateSubList.length
                              : _citySubList.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  if (_title == 'State') {
                                    widget.state.text =
                                        _stateSubList[index].state;
                                    _getCity(_stateSubList[index].lgas);
                                    _stateSubList = _stateList;
                                    widget.city.clear();
                                  } else if (_title == 'LGA') {
                                    widget.city.text = _citySubList[index];
                                    _citySubList = _cityList;
                                  }
                                });
                                controller.clear();
                                controller2.clear();
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 10.0, right: 10.0),
                                child: Text(
                                  _title == 'State'
                                      ? _stateSubList[index].state
                                      : _citySubList[index],
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_title == 'LGA' && _citySubList.isEmpty) {
                            widget.city.text = controller2.text;
                          }
                          _stateSubList = _stateList;
                          _citySubList = _cityList;

                          controller.clear();
                          controller2.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }
}

class NGNStatePickerWidget extends StatefulWidget {
  final String? title;
  final String countryCode;
  final TextEditingController state;
  final Function(String)? onStateChange;

  const NGNStatePickerWidget({
    super.key,
    this.title,
    required this.state,
    this.onStateChange,
    this.countryCode = '160',
  });

  @override
  State<NGNStatePickerWidget> createState() => _NGNStatePickerWidgetState();
}

class _NGNStatePickerWidgetState extends State<NGNStatePickerWidget> {
  final List<StateModel> _stateList = [];
  List<StateModel> _stateSubList = [];

  @override
  void initState() {
    super.initState();
    _getState();
  }

  Future<void> _getState() async {
    _stateList.clear();
    List<StateModel> subStateList = [];
    var jsonString = await rootBundle.loadString('assets/state.json');
    List<dynamic> body = json.decode(jsonString);

    subStateList =
        body.map((dynamic item) => StateModel.fromJson(item)).toList();
    subStateList.forEach((element) {
      if (element.countryId == widget.countryCode) {
        setState(() {
          _stateList.add(element);
        });
      }
    });
    _stateSubList = _stateList;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: widget.state,
      validator: null,
      title: widget.title ?? 'State/Province/Region',
      hintText: 'Select State',
      suffixWidget: InkWell(
        onTap: () {
          // try {
          //   if (widget.country.text.isNotEmpty) {
          //     final countryId = _countrySubList.where(
          //       (element) => element.name == widget.country.text,
          //     );
          //     _getState(countryId.first.id);
          //   }
          // } catch (e) {
          //   print('state error $e');
          // }
          // if (widget.country.text.isNotEmpty)
          _showDialog(context);
          // else
          //   _showSnackBar('Select Country');
        },
        child: const Icon(Icons.arrow_drop_down, color: Colors.green),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "State/Province/Region",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "State/Province/Region",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ///Text Field
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: TextField(
                          controller: widget.state,
                          onChanged: (val) => widget.onStateChange?.call(val),
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16.0,
                          ),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Search here...",
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 5,
                            ),
                            isDense: true,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),

                      ///Dropdown Items
                      Expanded(
                        child: ListView.builder(
                          itemCount: _stateSubList.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  widget.state.text = _stateSubList[index].name;

                                  _stateSubList = _stateList;
                                  widget.onStateChange
                                      ?.call(_stateSubList[index].name);
                                });
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                child: Text(
                                  _stateSubList[index].name,
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _stateSubList = _stateList;

                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }
}

class NGNCityPickerWidget extends StatefulWidget {
  final String? title;
  final String? stateId;
  final TextEditingController cityController;
  final Function(String)? onStateChange;

  const NGNCityPickerWidget({
    super.key,
    this.title,
    this.stateId,
    required this.cityController,
    this.onStateChange,
  });

  @override
  State<NGNCityPickerWidget> createState() => _NGNCityPickerWidgetState();
}

class _NGNCityPickerWidgetState extends State<NGNCityPickerWidget> {
  List<dynamic>? cityCachedData;
  List<String> _cityList = [];
  List<String> _citySubList = [];

  @override
  void initState() {
    super.initState();
    _getCity();
  }

  Future<void> _getCity() async {
    try {
      late List<dynamic> body;
      List<CityWithLgaModel> subCityList = [];

      _cityList.clear();
      if (cityCachedData != null) {
        body = cityCachedData!;
      } else {
        var jsonString =
            await rootBundle.loadString('assets/state_and_lga.json');
        body = json.decode(jsonString);
      }

      subCityList =
          body.map((dynamic item) => CityWithLgaModel.fromJson(item)).toList();

      _cityList = subCityList.firstWhere((element) {
        return element.alias.trim().replaceAll('_', ' ').toLowerCase() ==
            widget.stateId?.toLowerCase();
      }).lgas;

      _citySubList = _cityList;
      setState(() {});
    } catch (e) {
      log('city error for state ${widget.stateId}:  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: widget.cityController,
      validator: null,
      title: widget.title ?? 'City',
      hintText: 'Select City',
      //   readOnly: true,
      suffixWidget: InkWell(
        onTap: () async {
          // if (_citySubList.isEmpty || _cityList.isEmpty) {
          await _getCity();
          // }

          _showDialog(context);
        },
        child: const Icon(Icons.arrow_drop_down, color: Colors.black),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "LGA",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "City",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ///Text Field
                      TextField(
                        controller: widget.cityController,
                        onChanged: (val) => widget.onStateChange?.call(val),
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16.0,
                        ),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: "Search here...",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 5,
                          ),
                          isDense: true,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),

                      ///Dropdown Items
                      if (widget.stateId == null || _citySubList.isEmpty)
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              const VSpace(40),
                              SizedBox(
                                width: 0.60.sw,
                                child: Text(
                                  "Please select a state before selecting local government area",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: _citySubList.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  setState(() {
                                    widget.cityController.text =
                                        _citySubList[index];

                                    _citySubList = _cityList;
                                    widget.onStateChange
                                        ?.call(_citySubList[index]);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20.0,
                                    left: 10.0,
                                    right: 10.0,
                                  ),
                                  child: Text(
                                    _citySubList[index],
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      TextButton(
                        onPressed: () {
                          _citySubList = _cityList;

                          Navigator.pop(context);
                        },
                        child: const TextWidget('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }
}

class StateLgaModel {
  final String state;
  final String alias;
  final List<String> lgas;

  StateLgaModel({
    required this.state,
    required this.alias,
    required this.lgas,
  });

  factory StateLgaModel.fromJson(Map<String, dynamic> json) => StateLgaModel(
        state: json["state"],
        alias: json["alias"],
        lgas: List<String>.from(json["lgas"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "alias": alias,
        "lgas": List<dynamic>.from(lgas.map((x) => x)),
      };
}
