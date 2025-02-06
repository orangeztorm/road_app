// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ConvertCurrencyEntity extends Equatable {
  final num rate;
  final num destinationAmount;

  const ConvertCurrencyEntity({
    required this.rate,
    required this.destinationAmount,
  });

  @override
  List<Object?> get props => [
        rate,
        destinationAmount,
      ];

  @override
  bool get stringify => true;
}
