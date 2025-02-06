// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_function_literals_in_foreach_calls, library_private_types_in_public_api, must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_app/cores/__cores.dart';

class CountryStateCityPicker extends StatefulWidget {
  TextEditingController country;
  TextEditingController state;
  TextEditingController city;
  InputBorder? textFieldInputBorder;
  String? lgaHeader;
  TextEditingController? countryCode;
  final bool isCountryFixed;

  CountryStateCityPicker({
    super.key,
    required this.country,
    required this.state,
    required this.city,
    this.lgaHeader,
    this.textFieldInputBorder,
    this.countryCode,
    this.isCountryFixed = false,
  });

  @override
  _CountryStateCityPickerState createState() => _CountryStateCityPickerState();
}

class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
  List<CountryModel> _countryList = [];
  final List<StateModel> _stateList = [];
  final List<CityModel> _cityList = [];

  List<CountryModel> _countrySubList = [];
  List<StateModel> _stateSubList = [];
  List<CityModel> _citySubList = [];
  String _title = '';

  @override
  void initState() {
    super.initState();
    _getCountry().then((value) {
      try {
        if (widget.country.text.isNotEmpty) {
          final countryId = _countrySubList.where(
            (element) => element.name == widget.country.text,
          );
          _getState(countryId.first.id);
          widget.countryCode?.text = countryId.first.sortName;
        }
      } catch (e) {
        log('state error $e');
      }
    });
  }

  Future<void> _getCountry() async {
    _countryList.clear();
    var jsonString = await rootBundle.loadString('assets/country.json');
    List<dynamic> body = json.decode(jsonString);
    setState(() {
      _countryList =
          body.map((dynamic item) => CountryModel.fromJson(item)).toList();
      _countrySubList = _countryList;
    });
  }

  Future<void> _getState(String countryId) async {
    _stateList.clear();
    _cityList.clear();
    List<StateModel> subStateList = [];
    var jsonString = await rootBundle.loadString('assets/state.json');
    List<dynamic> body = json.decode(jsonString);

    subStateList =
        body.map((dynamic item) => StateModel.fromJson(item)).toList();
    subStateList.forEach((element) {
      if (element.countryId == countryId) {
        setState(() {
          _stateList.add(element);
        });
      }
    });
    _stateSubList = _stateList;
  }

  Future<void> _getCity(String stateId) async {
    _cityList.clear();
    List<CityModel> subCityList = [];
    var jsonString = await rootBundle.loadString('assets/city.json');
    List<dynamic> body = json.decode(jsonString);

    subCityList = body.map((dynamic item) => CityModel.fromJson(item)).toList();
    subCityList.forEach((element) {
      if (element.stateId == stateId) {
        setState(() {
          _cityList.add(element);
        });
      }
    });
    _citySubList = _cityList;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ///Country TextField
        TextFieldWidget(
          controller: widget.country,
          validator: null,
          hintText: 'Select Country',
          readOnly: true,
          suffixWidget: InkWell(
            onTap: () {
              setState(() => _title = 'Country');
              _showDialog(context);
            },
            child: Icon(
              Icons.arrow_drop_down,
              color: theme.iconTheme.color,
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
              try {
                if (widget.country.text.isNotEmpty) {
                  final countryId = _countrySubList.where(
                    (element) => element.name == widget.country.text,
                  );
                  _getState(countryId.first.id);
                }
              } catch (e) {
                log(e.toString());
              }
              setState(() => _title = 'State/Province/Region');
              if (widget.country.text.isNotEmpty) {
                _showDialog(context);
              } else {
                _showSnackBar('Select Country', theme);
              }
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
              setState(() => _title = 'City');
              if (widget.state.text.isNotEmpty) {
                _showDialog(context);
              } else {
                _showSnackBar('Select State/Province/Region', theme);
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
    TextEditingController controller3 = TextEditingController();

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
                          controller: _title == 'Country'
                              ? controller
                              : _title == 'State/Province/Region'
                                  ? controller2
                                  : controller3,
                          onChanged: (val) {
                            setState(() {
                              if (_title == 'Country') {
                                _countrySubList = _countryList
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(
                                            controller.text.toLowerCase()))
                                    .toList();
                              } else if (_title == 'State/Province/Region') {
                                _stateSubList = _stateList
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(
                                            controller2.text.toLowerCase()))
                                    .toList();
                              } else if (_title == 'City') {
                                _citySubList = _cityList
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(
                                            controller3.text.toLowerCase()))
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
                          itemCount: _title == 'Country'
                              ? _countrySubList.length
                              : _title == 'State/Province/Region'
                                  ? _stateSubList.length
                                  : _citySubList.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  if (_title == "Country") {
                                    widget.country.text =
                                        _countrySubList[index].name;
                                    widget.countryCode?.text =
                                        _countrySubList[index].sortName;
                                    _getState(_countrySubList[index].id);
                                    _countrySubList = _countryList;
                                    widget.state.clear();
                                    widget.city.clear();
                                  } else if (_title ==
                                      'State/Province/Region') {
                                    widget.state.text =
                                        _stateSubList[index].name;
                                    _getCity(_stateSubList[index].id);
                                    _stateSubList = _stateList;
                                    widget.city.clear();
                                  } else if (_title == 'City') {
                                    widget.city.text = _citySubList[index].name;
                                    _citySubList = _cityList;
                                  }
                                });
                                controller.clear();
                                controller2.clear();
                                controller3.clear();
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 10.0, right: 10.0),
                                child: Text(
                                  _title == 'Country'
                                      ? _countrySubList[index].name
                                      : _title == 'State/Province/Region'
                                          ? _stateSubList[index].name
                                          : _citySubList[index].name,
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
                          if (_title == 'City' && _citySubList.isEmpty) {
                            widget.city.text = controller3.text;
                          }
                          _countrySubList = _countryList;
                          _stateSubList = _stateList;
                          _citySubList = _cityList;

                          controller.clear();
                          controller2.clear();
                          controller3.clear();
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

  void _showSnackBar(
    String message,
    theme,
  ) {
    Toast.showError('Error');
  }
}

class NGStatePickerWidget extends StatefulWidget {
  final String? title;
  final String countryCode;
  final TextEditingController state;
  final Function(String)? onStateChange;

  const NGStatePickerWidget({
    super.key,
    this.title,
    required this.state,
    this.onStateChange,
    this.countryCode = '160',
  });

  @override
  State<NGStatePickerWidget> createState() => _NGStatePickerWidgetState();
}

class _NGStatePickerWidgetState extends State<NGStatePickerWidget> {
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

class NGCityPickerWidget extends StatefulWidget {
  final String? title;
  final String? stateId;
  final TextEditingController cityController;
  final Function(String)? onStateChange;

  const NGCityPickerWidget({
    super.key,
    this.title,
    this.stateId,
    required this.cityController,
    this.onStateChange,
  });

  @override
  State<NGCityPickerWidget> createState() => _NGCityPickerWidgetState();
}

class _NGCityPickerWidgetState extends State<NGCityPickerWidget> {
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
      barrierLabel: "City",
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

class CountryModel {
  String id;
  String sortName;
  String name;
  String phoneCode;

  CountryModel(
      {required this.id,
      required this.sortName,
      required this.name,
      required this.phoneCode});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        id: json['id'] as String,
        sortName: json['sortname'] as String,
        name: json['name'] as String,
        phoneCode: json['phonecode'] as String);
  }
}

class StateModel {
  String id;
  String name;
  String countryId;

  StateModel({required this.id, required this.name, required this.countryId});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        id: json['id'] as String,
        name: json['name'] as String,
        countryId: json['country_id'] as String);
  }
}

class CityModel {
  String id;
  String name;
  String stateId;

  CityModel({required this.id, required this.name, required this.stateId});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      stateId: json['state_id'] as String,
    );
  }
}

class CityWithLgaModel {
  String alias;
  String state;
  final List<String> lgas;

  CityWithLgaModel({
    required this.alias,
    required this.state,
    required this.lgas,
  });

  factory CityWithLgaModel.fromJson(Map<String, dynamic> json) {
    return CityWithLgaModel(
      alias: json['alias'] as String,
      state: json['state'] as String,
      lgas: (json['lgas'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}
