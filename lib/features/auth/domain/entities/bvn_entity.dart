// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class BvnEntitiy extends Equatable {
  final BvnData data;

  const BvnEntitiy({
    required this.data,
  });

  @override
  List<Object> get props => [data];

  @override
  bool get stringify => true;
}

class BvnData extends Equatable {
  final String? phoneNo;
  final String? nextStep;

  const BvnData({
    required this.phoneNo,
    required this.nextStep,
  });

  @override
  List<Object?> get props => [phoneNo, nextStep];

  @override
  bool get stringify => true;
}
