enum DBExceptions {
  EMAIL_EXISTS,
  EMAIL_NOT_FOUND,
  INVALID_PASSWORD,
  OPERATION_NOT_ALLOWED,
  TOO_MANY_ATTEMPTS_TRY_LATER,
  USER_DISABLED
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString();
  }
}
