import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:it_roots_task/core/constants/api_constans.dart';
import 'package:it_roots_task/service_locator.dart';
import 'package:it_roots_task/core/network/api_utlis.dart';

abstract class INetworkClient {
  Future<Either<String, Response>> getData({required String endPoint});
  Future<Either<String, Response>> postData({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    String bodyString = "",
    bool isbodyString = false,
    bool isFormData = false,
  });
}

class NetworkClient implements INetworkClient {
  final ApiUtils apiUtils;

  NetworkClient({required this.apiUtils});

  static final instance = NetworkClient(apiUtils: locator<ApiUtils>());

  Dio dio = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(milliseconds: 30000),
    receiveTimeout: const Duration(milliseconds: 30000),
    sendTimeout: const Duration(milliseconds: 30000),
    headers: locator<ApiUtils>().headers,
  ))
    ..interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));

  @override
  Future<Either<String, Response>> getData({required String endPoint}) async {
    dio.options.headers = apiUtils.headers;

    try {
      final response = await dio.get("${ApiConstants.baseUrl}$endPoint");
      print("ressssssss ${response}");
      return Right(response);
    } on DioException catch (e) {
      return Left(await getDioError(e: e));
    }
  }

  @override
  Future<Either<String, Response>> postData({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    String bodyString = "",
    bool isbodyString = false,
    bool isFormData = false,
  }) async {
    dio.options.headers = isFormData ? apiUtils.headersForm : apiUtils.headers;

    try {
      final response = await dio.post(
        "${ApiConstants.baseUrl}$endPoint",
        queryParameters: query,
        data: isFormData
            ? FormData.fromMap(body ?? {})
            : isbodyString
                ? jsonEncode(bodyString)
                : body,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(await getDioError(e: e));
    }
  }

  Future<String> getDioError({required DioException e}) async {
    if (DioExceptionType.receiveTimeout == e.type ||
        DioExceptionType.connectionTimeout == e.type) {
      return 'Server is not reachable. Please verify your internet connection and try again';
    } else if (DioExceptionType.badResponse == e.type) {
      if (e.response!.statusCode == 401) {
        return 'Status Code 401';
      }
      if (e.response!.statusCode == 404) {
        return 'Not Found';
      }
      if (e.response!.statusCode == 500) {
        return 'Internal Server Error';
      }
      return '${e.response?.data}';
    } else if (DioExceptionType.connectionError == e.type) {
      if (e.message!.contains('SocketException')) {
        return 'Network Error';
      }
    }
    return 'Problem connecting to the server. Please try again.';
  }
}
