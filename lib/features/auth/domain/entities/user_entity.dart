import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final User? user;

  const UserEntity({required this.user});

  @override
  List<Object?> get props => [user];

  @override
  bool get stringify => true;
}

class User extends Equatable {
  final int accountId;
  final String accountNo;
  final String accountName;
  final DateTime createdAt;
  final String tier;
  final bool isAccountUpgrading;
  final String? photoPath;
  final String phoneNo;
  final String gender;
  final String dob;
  final String? email;
  final String firstName;
  final String lastName;
  final String otherNames;
  final String residentialAddress;
  final String? failedReason;
  final String? quidaxDisplayName;
  final String? quidaxUserId;
  final bool? emailVerified;
  final String? beamTag;

  const User({
    required this.accountId,
    required this.accountNo,
    required this.accountName,
    required this.createdAt,
    required this.tier,
    required this.isAccountUpgrading,
    required this.photoPath,
    required this.phoneNo,
    required this.gender,
    required this.dob,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.otherNames,
    required this.residentialAddress,
    required this.failedReason,
    required this.quidaxDisplayName,
    required this.quidaxUserId,
    required this.emailVerified,
    required this.beamTag,
  });

  String get fullName => '${firstName.trim()} ${lastName.trim()}';

  @override
  List<Object?> get props {
    return [
      accountId,
      accountNo,
      accountName,
      createdAt,
      tier,
      isAccountUpgrading,
      photoPath,
      phoneNo,
      gender,
      dob,
      email,
      firstName,
      lastName,
      otherNames,
      residentialAddress,
      failedReason,
      quidaxDisplayName,
      quidaxUserId,
      emailVerified,
      beamTag,
    ];
  }

  @override
  bool get stringify => true;
}
