class ErrorResponse {
  final int? code;
  final String? timestamp, path, method, message;

  ErrorResponse({
    required this.code,
    required this.timestamp,
    required this.path,
    required this.method,
    required this.message,
  });
}
