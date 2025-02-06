final class CryptoWalletHelper {
  static String getFullName(String? coinKey) {
    if (coinKey == null) return 'Unknown';

    final baseCoin = coinKey.split('_').first.toUpperCase();
    final network = _coinNetworkName[coinKey] ?? 'Unknown';

    return '$baseCoin on $network';
  }

  static String getLogoUrl(String? coinKey) {
    if (coinKey == null) return 'https://example.com/default_logo.png';

    return _coinNetworkLogo[coinKey] ?? 'https://example.com/default_logo.png';
  }

  static const Map _coinNetworkName = {
    'usdt_matic': 'Matic',
    'usdt': 'Ethereum',
    'usdt_tron': 'Tron',
    'usdt_stellar': 'Stellar',
    'usdc': 'Ethereum',
    'usdc_tron': 'Tron',
    'usdc_matic': 'Matic',
    'usdc_stellar': 'Stellar',
    'cusd': 'Celo',
    'pyusd': 'Fund Paypal',
  };

  static const Map _coinNetworkLogo = {
    'usdt_matic':
        'https://s2.coinmarketcap.com/static/img/coins/64x64/3890.png',
    'usdt': 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png',
    'usdt_tron': 'https://s2.coinmarketcap.com/static/img/coins/64x64/1958.png',
    'usdt-tron': 'https://s2.coinmarketcap.com/static/img/coins/64x64/1958.png',
    'usdt_stellar':
        'https://s2.coinmarketcap.com/static/img/coins/64x64/512.png',
    'usdc': 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png',
    'usdc_tron': 'https://s2.coinmarketcap.com/static/img/coins/64x64/1958.png',
    'usdc_matic':
        'https://s2.coinmarketcap.com/static/img/coins/64x64/3890.png',
    'usdc_stellar':
        'https://s2.coinmarketcap.com/static/img/coins/64x64/512.png',
    'cusd': 'https://s2.coinmarketcap.com/static/img/coins/64x64/5567.png',
    "pyusd": "assets/images/fund_wallet/round_poaypal_icon.png",
  };
}
