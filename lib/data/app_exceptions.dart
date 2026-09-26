import '../res/app_strings/app_strings.dart';

/// ForgeFit App Exception Hierarchy
class AppExceptions implements Exception {
  final dynamic _message;
  AppExceptions([this._message]);

  @override
  String toString() {
    if (_message == null) return AppStrings.errGeneric;
    if (_message is Map) {
      return _message['message']
          ?? _message['error']
          ?? _message['detail']
          ?? AppStrings.errGeneric;
    }
    return _message.toString();
  }

  String get message => toString();
}

class InternetExceptions extends AppExceptions {
  InternetExceptions() : super(AppStrings.errNetwork);
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut() : super(AppStrings.errTimeout);
}

class ServerException extends AppExceptions {
  ServerException() : super(AppStrings.errServer);
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException() : super(AppStrings.errUnauth);
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? msg]) : super(msg ?? 'Invalid request. Please check your input.');
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? msg]) : super(msg ?? 'Resource not found.');
}

class ValidationException extends AppExceptions {
  final Map<String, dynamic>? errors;
  ValidationException([String? msg, this.errors]) : super(msg ?? 'Validation failed.');

  /// Returns first field error if available
  String get firstError {
    if (errors == null || errors!.isEmpty) return message;
    final first = errors!.values.first;
    if (first is List && first.isNotEmpty) return first.first.toString();
    return first.toString();
  }
}
