
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/data/model/response/diy_model.dart';
import 'package:template/domain/export/domain_export.dart';

class DIYRepository {
  final _dio = GetIt.I.get<DioClient>();

  ///
  /// Get all
  ///
  Future<void> getAll({
    required Function(List<ConversationModel> event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.diy);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as List<dynamic>;
      onSuccess(results.map((e) => ConversationModel.fromMap(e as Map<String, dynamic>)).toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Add
  ///
  Future<void> add({
    required DIYModel data,
    required Function(DIYModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response = await _dio.post(EndPoints.diy, data: data.toJson());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(DIYModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Update
  ///
  Future<void> update({
    required String id,
    required DIYModel data,
    required Function(DIYModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    final String _uri = '${EndPoints.diy}/$id';

    try {
      response = await _dio.put(_uri, data: data.toMap());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(DIYModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<void> delete({
    required String id,
    required Function(DIYModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response = await _dio.delete('${EndPoints.diy}/$id');
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(DIYModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Get paginate provinces "page": 1, "limit": 10, filter
  ///
  Future<void> paginate(
    int page,
    int limit,
    String filter, {
    required Function(List<DIYModel> event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    String _uri = '${EndPoints.diy}/paginate?page=$page&limit=$limit'.toString();

    // add condition filter
    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri = '${EndPoints.diy}/paginate?page=$page&limit=$limit$filter';
    }
    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data['results'] as List<dynamic>;
      onSuccess(results.map((e) => DIYModel.fromMap(e as Map<String, dynamic>)).toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Find bang-bang-cap by id
  ///
  Future<void> find(
    String id, {
    String? filter,
    required Function(DIYModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String _uri = '${EndPoints.diy}/$id';
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

    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(DIYModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
