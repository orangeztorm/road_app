class ServerException implements Exception {
  const ServerException([this.message, this.trace]);

  final String? message;
  final StackTrace? trace;

  String getLog() => "$message \nStack -> $trace";
}
