import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/data/model/response/settings_model.dart';
import 'package:template/data/repositories/policy_terms.dart';
import 'package:template/domain/export/domain_export.dart';

class SettingRepository {
  final _dio = GetIt.I.get<DioClient>();

  ///
  /// Get setting.
  ///
  Future<void> getSetting({
    String? filter,
    required Function(SettingsModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    String _uri = EndPoints.settings;

    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri = '${EndPoints.settings}$filter';
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final results = response.data as dynamic;

      // final _listSettingModels = results.map((e) => SettingsModel.fromMap(e as Map<String, dynamic>)).toList();
      onSuccess(SettingsModel.fromMap(results as Map<String, dynamic>));
      // onSuccess(_listSettingModels.first);
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> find(
    String id, {
    String? filter,
    required Function(SettingsModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String _uri = '${EndPoints.settings}/one?appType=A4_MATH';

    late Response response;

    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri += filter.toString();
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }

    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final results = response.data;
      onSuccess(
          results.map((e) => SettingsModel.fromMap(e as Map<String, dynamic>)));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> getPolicyTerms({
    String? fields,
    required Function(PolicyTerms event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    String _uri = EndPoints.policy_terms;

    if (!IZIValidate.nullOrEmpty(fields)) {
      _uri = '${EndPoints.policy_terms}&$fields';
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      try {
        final dynamic responseData = response.data;

        // Check if the responseData is a List
        if (responseData is List) {
          final _listSettingModels = responseData
              .map((e) => PolicyTerms.fromJson(e as Map<String, dynamic>))
              .toList();

          if (_listSettingModels.isNotEmpty) {
            onSuccess(_listSettingModels.first);
          } else {
            onError("Empty list received");
          }
        } else if (responseData is Map<String, dynamic>) {
          // If responseData is a Map, it means it's a single object, not a list
          onSuccess(PolicyTerms.fromJson(responseData));
        } else {
          onError("Invalid response format");
        }
      } catch (e) {
        onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      }
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
