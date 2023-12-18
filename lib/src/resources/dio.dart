import 'package:dio/dio.dart';
import 'logging.dart';

const API_URL = 'https://hzung.sontran.us';

final endpoint = '$API_URL';

class DioClient {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: endpoint,
      receiveDataWhenStatusError: false,
      connectTimeout: Duration(milliseconds: 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    ),
  )..interceptors.add(Logging());

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

  static getWithTokenParams(String url, Map<String, dynamic>? params, String? token) async {
    Options options = (token == null)
        ? new Options(headers: {"Content-type": "application/json"})
        : new Options(
            headers: {"Authorization": "Bearer $token", "Content-type": "application/json"});
    return await _dio.get(endpoint + url, queryParameters: params, options: options);
  }

  static getWithTokenById(String url, String? id, String? token) async {
    final path = '$url/$id';
    Options options = (token == null)
        ? new Options(headers: {"Content-type": "application/json"})
        : new Options(
            headers: {"Authorization": "Bearer $token", "Content-type": "application/json"});
    return await _dio.get(endpoint + path, options: options);
  }

  static getWithTokenByIdAndParam(
      String url, String? id, Map<String, dynamic>? param, String? token) async {
    final path = '$url/$id';
    Options options = (token == null)
        ? new Options(headers: {"Content-type": "application/json"})
        : new Options(
            headers: {"Authorization": "Bearer $token", "Content-type": "application/json"});
    return await _dio.get(endpoint + path, queryParameters: param, options: options);
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

  static auth(url, firebaseToken, deviceToken) async {
    return await _dio.post(endpoint + url + "?token=$firebaseToken&deviceToken=$deviceToken",
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
          headers: {"Authorization": "Bearer $token", "Content-type": "application/json"},
        ));
  }

  static put(url, body) async {
    return await _dio.put(endpoint + url, data: body);
  }

  static putBodyWithToken(url, body, token) async {
    return await _dio.put(
      endpoint + url,
      data: body,
      options: Options(
        headers: {"Authorization": "Bearer $token", "Content-type": "application/json"},
      ),
    );
  }

  static putParamWithToken(url, param, token) async {
    return await _dio.put(
      "${endpoint + url}/$param",
      options: Options(
        headers: {"Authorization": "Bearer $token", "Content-type": "application/json"},
      ),
    );
  }

  static putParamWithToken2(
      url, Map<String, String> params, Map<String, dynamic> body, token) async {
    var formData = FormData.fromMap(body);
    return await _dio.put(
      "${endpoint + url}",
      options: Options(
        headers: {"Authorization": "Bearer $token", "Content-type": "application/json"},
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
