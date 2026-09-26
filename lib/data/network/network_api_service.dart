import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../res/app_url/app_url.dart';
import '../app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiServices extends BaseApiServices {
  final _storage = GetStorage();

  // ─── Storage Keys ─────────────────────────────────────────────
  static const _keyAccessToken  = 'access_token';
  static const _keyRefreshToken = 'refresh_token';

  // ─── No-auth endpoints ────────────────────────────────────────
  static final _publicRoutes = [
    AppUrl.login,
    AppUrl.signup,
    AppUrl.forgotPwd,
    AppUrl.verifyOtp,
    AppUrl.resetPwd,
  ];

  // ─── Build Headers ────────────────────────────────────────────
  Future<Map<String, String>> _getHeaders(
      String url, {
        Map<String, String>? extra,
      }) async {
    final headers = <String, String>{
      'Content-Type':  'application/json',
      'Accept':        'application/json',
      'X-App-Version': '1.0.0',
      'X-Platform':    Platform.isAndroid ? 'android' : 'ios',
    };

    // Attach token for protected routes
    final isPublic = _publicRoutes.any((r) => url.contains(r));
    if (!isPublic) {
      final token = _storage.read(_keyAccessToken) ?? '';
      if (token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    if (extra != null) headers.addAll(extra);
    return headers;
  }

  // ─── GET ──────────────────────────────────────────────────────
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) print('🌐 GET → $url');
    try {
      final headers  = await _getHeaders(url);
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 20));
      return _returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  // ─── POST ─────────────────────────────────────────────────────
  @override
  Future<dynamic> postApi(
      dynamic data,
      String url, {
        Map<String, String>? headers,
      }) async {
    if (kDebugMode) {
      print('🌐 POST → $url');
      print('📦 Body  → $data');
    }
    try {
      final mergedHeaders = await _getHeaders(url, extra: headers);
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: mergedHeaders)
          .timeout(const Duration(seconds: 30));
      return _returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  // ─── PUT ──────────────────────────────────────────────────────
  @override
  Future<dynamic> putApi(dynamic data, String url) async {
    if (kDebugMode) print('🌐 PUT → $url');
    try {
      final headers  = await _getHeaders(url);
      final response = await http
          .put(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 30));
      return _returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  // ─── DELETE ───────────────────────────────────────────────────
  @override
  Future<dynamic> deleteApi(String url) async {
    if (kDebugMode) print('🌐 DELETE → $url');
    try {
      final headers  = await _getHeaders(url);
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 20));
      return _returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  // ─── Response Handler ─────────────────────────────────────────
  dynamic _returnResponse(http.Response response) {
    final contentType = response.headers['content-type'] ?? '';

    if (kDebugMode) {
      print('📡 Status  → ${response.statusCode}');
      print('📡 Content → $contentType');
      if (!contentType.contains('application/pdf')) {
        print('📡 Body    → ${response.body}');
      }
    }

    // PDF binary response
    if (contentType.contains('application/pdf')) {
      if (kDebugMode) print('📄 PDF response received');
      return response.bodyBytes;
    }

    final responseBody = _tryDecodeJson(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseBody;

      case 400:
        throw BadRequestException(
          responseBody['message'] ?? responseBody['error'],
        );

      case 401:
        _clearTokens();
        throw UnauthorizedException();

      case 403:
        throw UnauthorizedException();

      case 404:
        throw NotFoundException(
          responseBody['message'] ?? 'Resource not found',
        );

      case 422:
        throw ValidationException(
          responseBody['message'],
          responseBody['errors'],
        );

      case 500:
      case 502:
      case 503:
        throw ServerException();

      default:
        throw AppExceptions(
          responseBody['message'] ?? 'Error: ${response.statusCode}',
        );
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────
  Map<String, dynamic> _tryDecodeJson(String body) {
    if (body.isEmpty) return {};
    try {
      final decoded = jsonDecode(body);
      return decoded is Map<String, dynamic> ? decoded : {'data': decoded};
    } catch (_) {
      return {};
    }
  }

  void _clearTokens() {
    _storage.remove(_keyAccessToken);
    _storage.remove(_keyRefreshToken);
    if (kDebugMode) print('🔑 Tokens cleared — session expired');
  }

  // ─── Token Management (public) ────────────────────────────────
  void saveTokens({required String access, String? refresh}) {
    _storage.write(_keyAccessToken, access);
    if (refresh != null) _storage.write(_keyRefreshToken, refresh);
  }

  String? get accessToken  => _storage.read(_keyAccessToken);
  String? get refreshToken => _storage.read(_keyRefreshToken);
  bool   get hasToken      => (accessToken ?? '').isNotEmpty;
}
