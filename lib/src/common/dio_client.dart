import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../logger.dart';
import '../resources/logging.dart';

import 'dart:developer' as developer;

final endpoint = "https://hzung.sontran.us";
// final endpoint = "http://hzung.sontran.us:8080";

class DioClient {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: endpoint,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    ),
  )
    ..interceptors.add(Logging())
    ..interceptors.add(InterceptorsWrapper(
      onResponse: (Response<dynamic> response, handler) {
        if (response.statusCode! < 200 || response.statusCode! >= 300) {
          return handler.reject(
            DioError(
              requestOptions: response.requestOptions,
              response: response,
              error:
                  'Received non-successful status code: ${response.statusCode}',
            ),
          );
        }
        return handler.next(response);
      },
    ));

  static get(url) async {
    return await _dio.get(endpoint + url,
        options: Options(
          headers: {"Content-type": "application/json"},
        ));
  }

  static getWithToken(url, token) async {
    return await _dio.get(endpoint + url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
  }

  static getWithTokenParams(
      String url, Map<String, dynamic>? params, String? token) async {
    Options options = (token == null)
        ? new Options(headers: {"Content-type": "application/json"})
        : new Options(headers: {
            "Authorization": "Bearer $token",
            "Content-type": "application/json"
          });
    return await _dio.get(endpoint + url,
        queryParameters: params, options: options);
  }

  static getWithTokenById(String url, String? id, String? token) async {
    final path = '$url/$id';
    Options options = (token == null)
        ? new Options(headers: {"Content-type": "application/json"})
        : new Options(headers: {
            "Authorization": "Bearer $token",
            "Content-type": "application/json"
          });
    return await _dio.get(endpoint + path, options: options);
  }

  static getWithTokenByIdAndParam(String url, String? id,
      Map<String, dynamic>? param, String? token) async {
    final path = '$url/$id';
    Options options = (token == null)
        ? new Options(headers: {"Content-type": "application/json"})
        : new Options(headers: {
            "Authorization": "Bearer $token",
            "Content-type": "application/json"
          });
    return await _dio.get(endpoint + path,
        queryParameters: param, options: options);
  }

  static post(url, body) async {
    return await _dio.post(endpoint + url,
        data: body,
        options: Options(
          headers: {
            "Content-type": "application/json",
            "withCredentials": true,
          },
        ));
  }

  static postOneParam(String url, {Map<String, dynamic>? params}) async {
    return await _dio.post(
      Uri.parse(endpoint + url).replace(queryParameters: params).toString(),
    );
  }

  static auth(url, firebaseToken, deviceToken) async {
    return await _dio.post(
        endpoint + url + "?token=$firebaseToken&deviceToken=$deviceToken",
        options: Options(
          headers: {
            "Content-type": "application/json",
            "withCredentials": true,
          },
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ));
  }

  static logout(url, deviceToken) async {
    return await _dio.post(endpoint + url + "?deviceToken=$deviceToken",
        options: Options(
          headers: {
            "Content-type": "application/json",
            "withCredentials": true,
          },
          followRedirects: false,
          validateStatus: (status) => true,
        ));
  }

  static postWithToken(url, body, token) async {
    return await _dio.post(
      endpoint + url,
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json",
          "withCredentials": true,
        },
      ),
    );
  }

  static postFormDataWithToken(url, Map<String, dynamic> data, token) async {
    var formData = FormData.fromMap(data);
    return await _dio.post(endpoint + url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-type": "multipart/form-data",
            "withCredentials": true,
          },
        ));
  }

  static patch(url, body) async {
    return await _dio.patch(endpoint + url, data: body);
  }

  static patchWithToken(url, body, token) async {
    return await _dio.patch(endpoint + url,
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-type": "application/json"
          },
        ));
  }

  static put(url, body) async {
    return await _dio.put(endpoint + url, data: body);
  }

  static Future<Response<dynamic>> putCustom(String url, dynamic body) async {
    try {
      final response = await _dio.put(endpoint + url, data: body);
      return response;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      print('Error: $e');
      throw DioError(
        requestOptions: RequestOptions(path: url),
        error: 'Unknown error occurred',
      );
    }
  }

  // static putOneParam(url) async {
  //   developer.log(endpoint + url);
  //   return await _dio.put(endpoint + url);
  // }
  static putOneParam(String url, {Map<String, dynamic>? params}) async {
    return await _dio.put(
      Uri.parse(endpoint + url).replace(queryParameters: params).toString(),
    );
  }

  static putBodyWithToken(url, body, token) async {
    return await _dio.put(
      endpoint + url,
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json"
        },
      ),
    );
  }

  static putParamWithToken(url, param, token) async {
    return await _dio.put(
      "${endpoint + url}/$param",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json"
        },
      ),
    );
  }

  static putParamWithToken2(
      url, Map<String, String> params, Map<String, dynamic> body, token) async {
    var formData = FormData.fromMap(body);
    return await _dio.put(
      "${endpoint + url}",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json"
        },
      ),
      queryParameters: params,
      data: formData,
    );
  }

  static putFormDataWithToken(
      url, Map<String, dynamic> param, Map<String, dynamic> data, token) async {
    var formData = FormData.fromMap(data);
    return await _dio.put(
      endpoint + url,
      queryParameters: param,
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "multipart/form-data",
        },
      ),
    );
  }

  static deleteParam(url, param, token) async {
    return await _dio.delete(endpoint + url,
        queryParameters: param,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
  }
}
