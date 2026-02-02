import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wise_players/core/error/success_fail_result.dart';
import 'package:wise_players/data/_api/api_services/end_points.dart';

import '../dio_client.dart';

class ApiService {
  final Dio _dio = DioClient().dio;

  Future<Response> getUsers() async {
    return await _dio.get('/users');
  }

  Future<ApiResult<Map<String, dynamic>>> loginWithMac(
    Map<String, dynamic> data,
  ) async {
    try {
      Response res = await _dio.post('/api/device/register', data: data);

      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResult.success(res.data);
      } else {
        return ApiResult.failure(
          "Login failed with status code: ${res.statusCode}",
        );
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<ApiResult<Map<String, dynamic>>> validateStatus(
    Map<String, dynamic> pData,
    token,
    fingerprint,
  ) async {
    try {
      Response res = await _dio.post(
        '/api/device/validate',
        data: pData,
        // options: Options(
        //   headers: {
        //     "X-Device-Token": token,
        //     "X-Device-Fingerprint": fingerprint,
        //   },
        // ),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResult.success(res.data);
      } else {
        return ApiResult.failure(
          "Login failed with status code: ${res.data['message']}",
        );
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<ApiResult> hitPostApi({
    required reqData,
    required String endpoint,
  }) async {
    try {
      Response res = await _dio.post("$baseUrl$endpoint", data: reqData);

      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResult.success(res.data);
      } else {
        return ApiResult.failure(
          "Request failed with status code: ${res.statusCode} and ${res.data}",
        );
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<ApiResult<Map<String, dynamic>>> generateDeviceKey(
    Map<String, dynamic> pData,
  ) async {
    try {
      Response res = await _dio.post('/api/device/key', data: pData);

      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResult.success(res.data);
      } else {
        return ApiResult.failure(
          "Login failed with status code: ${res.data['message']}",
        );
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
