// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class VerifyOtpEntity extends Equatable {
  final VerifyOtpDetails? data;

  const VerifyOtpEntity({
    required this.data,
  });

  @override
  List<Object?> get props => [data];

  @override
  bool get stringify => true;
}

class VerifyOtpDetails extends Equatable {
  final String? phoneNo;
  final String? nextStep;
  final String? firstName;
  final String? lastName;
  final String? photo;
  final bool? existingUser;
  final Map<String, String>? occupations;
  final Map<String, String>? monthlyIncomeRange;

  const VerifyOtpDetails({
    required this.phoneNo,
    required this.nextStep,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.occupations,
    required this.monthlyIncomeRange,
    required this.existingUser,
  });

  @override
  List<Object?> get props {
    return [
      phoneNo,
      nextStep,
      firstName,
      lastName,
      photo,
      occupations,
      monthlyIncomeRange,
      existingUser,
    ];
  }

  @override
  bool get stringify => true;
}
