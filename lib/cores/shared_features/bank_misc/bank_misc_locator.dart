import 'package:road_app/cores/__cores.dart';

import '../../../app/locator.dart';

void setUpBankMiscLocator() {
  // Data Sources
  getIt.registerLazySingleton<BankMiscRemoteDataSource>(
    () => BankMiscRemoteDataSourceImpl(httpHelper: getIt<HttpHelper>()),
  );

  // Repositories
  getIt.registerLazySingleton<BankMiscRepository>(
    () => BankMiscRepositoryImpl(
      remoteDataSource: getIt<BankMiscRemoteDataSource>(),
    ),
  );

  // usecase
  getIt.registerLazySingleton(
    () => GetNigerianBanksUsecase(repository: getIt<BankMiscRepository>()),
  );

  getIt.registerLazySingleton(
    () => ResolveBankUsecase(repository: getIt<BankMiscRepository>()),
  );

  // bloc
  getIt.registerLazySingleton(
    () => GetNigeriaBanksBloc(
      getNigerianBanksUsecase: getIt<GetNigerianBanksUsecase>(),
    ),
  );

  getIt.registerFactory(
    () => ResolveBankAccountBloc(
      resolveBankUsecase: getIt<ResolveBankUsecase>(),
    ),
  );

  // cubit
  getIt.registerFactory(() => TimerCubit());
}
