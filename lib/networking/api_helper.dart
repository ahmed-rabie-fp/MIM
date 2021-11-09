import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../utils/app_exceptions.dart';


class ApiBaseHelper {
  static final Uri baseUri = Uri.parse("http://cms.s2.mim-apps.com/index.php/api/v1/content");

  Future<dynamic> get(Uri uri) async {
    var responseJson;
    try {
      final response = await http.get(uri);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    print('Api get received data!');
    return responseJson;
  }

  Future<dynamic> post(
      Uri uri, {
        Map<String, dynamic>? params,
        Map<String, String>? headers,
      }) async {
    var responseJson;
    try {
      final response = await http.post(
        uri,
        body: params,
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('Api posted and received data!');
    return responseJson;
  }

  Future<dynamic> put(
      Uri uri, {
        Map<String, dynamic>? params,
        Map<String, String>? headers,
      }) async {
    var responseJson;
    try {
      final response = await http.put(
        uri,
        body: params,
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('Api posted and received data!');
    return responseJson;
  }

  Future<dynamic> delete(
      Uri uri, {
        var params,
        Map<String, String>? headers,
      }) async {
    var responseJson;
    try {
      final response = await http.delete(
        uri,
        body: params,
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('Api posted and received data!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        print(responseJson.toString());
        return responseJson;
      case 204:
        return null;
      case 400:
        throw BadRequestException(response.body.toString());
        break;
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
        break;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        break;
    }
  }
}