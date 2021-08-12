import 'package:dio/dio.dart';

class ApiDataAndEndPoints {
  static String _baseUrl = 'https://student.valuxapps.com/api/';
  static String loginPathUrl = 'login';
  static String homePathUrl = 'home';
  static String getCategoriesPathUrl = 'categories';
  static String favoritesPathUrl = 'favorites';
  static String profilePathUrl = 'profile';
  static String registerPathUrl = 'register';
  static String updateProfilePathUrl = 'update-profile';
  static String searchProductsPathUrl = 'products/search';

  static Map<String, dynamic> _headers({
    String lang = 'en',
    String? token,
  }) =>
      {
        'Content-Type': 'application/json',
        'lang': lang,
        'Authorization': token ?? '',
      };
}

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiDataAndEndPoints._baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = ApiDataAndEndPoints._headers(
      lang: lang,
      token: token,
    );

    return await dio.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = ApiDataAndEndPoints._headers(
      lang: lang,
      token: token,
    );

    return await dio.post(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = ApiDataAndEndPoints._headers(
      lang: lang,
      token: token,
    );

    return await dio.put(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
