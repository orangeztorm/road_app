import 'package:road_app/cores/__cores.dart';

abstract class BankMiscRemoteDataSource {
  Future<GetNigeriaBankModel> getNigerianBanks();

  Future<ResolveBankModel> resolveBankAccount(RequestParam requestParam);

  Future<ConvertCurrencyData> convertAmount(RequestParam requestParam);
}

class BankMiscRemoteDataSourceImpl implements BankMiscRemoteDataSource {
  final HttpHelper httpHelper;

  BankMiscRemoteDataSourceImpl({required this.httpHelper});

  @override
  Future<GetNigeriaBankModel> getNigerianBanks() async {
    final Map<String, dynamic> response = await httpHelper.get('');

    return GetNigeriaBankModel.fromMap(response);
  }

  @override
  Future<ResolveBankModel> resolveBankAccount(
    RequestParam requestParam,
  ) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: 'ApiEndpoints.resolveBank',
      body: requestParam.toMap(),
    );

    return ResolveBankModel.fromMap(response);
  }

  @override
  Future<ConvertCurrencyData> convertAmount(RequestParam requestParam) async {
    final Map<String, dynamic> response = await httpHelper
        .get('ApiEndpoints.convertCurrency', query: requestParam.toMap());

    return ConvertCurrencyModel.fromMap(response).data;
  }
}
