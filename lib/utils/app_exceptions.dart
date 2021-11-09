class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message])
      : super(message,
      "Invalid Request: The request the client made is incorrect or corrupt,\n and the server can't understand it");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message])
      : super(message, "Unauthorised: The server understood the request but refuses to authorize it");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}