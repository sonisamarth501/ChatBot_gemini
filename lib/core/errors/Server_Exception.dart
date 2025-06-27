class ServerException implements Exception {
  final String message;

  ServerException([
    this.message = 'an error occured while communicating with the server.',
  ]);

  @override
  String toString() => 'ServerException: $message';
}
