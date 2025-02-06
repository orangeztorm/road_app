import 'package:road_app/cores/__cores.dart';

class ConvertAmountParam extends RequestParam {
  final String? currency;
  final String? destinationCurrency;
  final num? amount;

  const ConvertAmountParam({
    this.currency,
    this.destinationCurrency,
    this.amount,
  });

  @override
  List<Object?> get props => [currency, destinationCurrency, amount];

  ConvertAmountParam copyWith({
    String? currency,
    String? destinationCurrency,
    num? amount,
  }) {
    return ConvertAmountParam(
      currency: currency ?? this.currency,
      destinationCurrency: destinationCurrency ?? this.destinationCurrency,
      amount: amount ?? this.amount,
    );
  }

  @override
  bool get stringify => true;

  @override
  Map<String, dynamic> toMap() {
    return {
      'currency': currency,
      'destinationCurrency': destinationCurrency,
      'amount': amount,
    };
  }
}
