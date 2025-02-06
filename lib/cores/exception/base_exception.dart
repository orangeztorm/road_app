import '../failures/base.dart';

class BaseFailures extends Failures {
  const BaseFailures({required super.message, super.trace});
}

class SocketFailures extends Failures {
  const SocketFailures({required super.message, super.trace});
}
