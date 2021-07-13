import 'package:dio/dio.dart';

import '../../components/constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      path,
      queryParameters: query,
    );
  }
}
