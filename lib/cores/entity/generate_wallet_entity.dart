import 'package:equatable/equatable.dart';

class GeneralWalletListEntity extends Equatable {
  final List<GeneralWalletEntity> wallets;

  const GeneralWalletListEntity({
    required this.wallets,
  });

  @override
  List<Object?> get props => [wallets];
}

class GeneralWalletEntity extends Equatable {
  final String currency;
  final String name;
  final num balance;
  final bool isCrypto;
  final String photoId;
  final String? walletAddress;
  final String? defaultNetwork;

  const GeneralWalletEntity({
    required this.currency,
    required this.name,
    required this.balance,
    required this.isCrypto,
    required this.photoId,
    this.walletAddress,
    this.defaultNetwork,
  });

  @override
  List<Object?> get props => [
        currency,
        balance,
        isCrypto,
        photoId,
        walletAddress,
        defaultNetwork,
        name,
      ];
}
