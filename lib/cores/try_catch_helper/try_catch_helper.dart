import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

// import '../../shared_features/logger/crash_logger/crash_logger.dart';
import '../exception/base_exception.dart';
import '../failures/base.dart';
import '../failures/error_text.dart';
import '../utils/__utils.dart';

typedef TryCatchHandler<T> = Future<T> Function(dynamic error);

class RepoTryCatchHelper<T> {
  // final CrashLogger crashLogger = FirebaseCrashLoggerHelper();

  Future<Either<Failures, T>> tryAction(Future<T> Function() action) async {
    try {
      final T result = await action.call();

      return Right(result);
    } on TypeError catch (e, s) {
      LoggerHelper.log(e, s);
      // crashLogger.logCrash(e, s: s, fatal: true);

      return const Left(BaseFailures(message: ErrorText.formatError));
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      // crashLogger.logCrash(e, s: s, fatal: true);

      return const Left(BaseFailures(message: ErrorText.formatError));
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);

      return const Left(BaseFailures(message: ErrorText.timeoutError));
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      // crashLogger.logCrash(e, s: s, fatal: true);

      return const Left(SocketFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);
      // crashLogger.logCrash(e, s: s, fatal: true);

      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }
}
