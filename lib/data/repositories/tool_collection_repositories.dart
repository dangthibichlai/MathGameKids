import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/data/model/response/tool_collection_model.dart';
import 'package:template/domain/export/domain_export.dart';

class ToolCollectionRepository {
  final _dio = GetIt.I.get<DioClient>();

  ///
  /// Get all
  ///
  Future<void> getAll({
    required Function(List<ToolCollectionModel> event) onSuccess,
    String? filter,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String _uri = EndPoints.toolCollection;

    if (filter != null) {
      _uri += '?$filter';
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
      final _results = response.data as List<dynamic>;
      onSuccess(_results
          .map((e) => ToolCollectionModel.fromMap(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Add
  ///
  Future<void> add({
    required ToolCollectionModel data,
    required Function(ToolCollectionModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response = await _dio.post(EndPoints.toolCollection, data: data.toJson());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final _results = response.data as dynamic;
      onSuccess(ToolCollectionModel.fromMap(_results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Update
  ///
  Future<void> update({
    required String id,
    required ToolCollectionModel data,
    required Function(ToolCollectionModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    final String _uri = '${EndPoints.toolCollection}/$id';

    try {
      response = await _dio.put(_uri, data: data.toMap());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final _results = response.data as dynamic;
      onSuccess(ToolCollectionModel.fromMap(_results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<void> delete({
    required String id,
    required Function(ToolCollectionModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response = await _dio.delete('${EndPoints.toolCollection}/$id');
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final _results = response.data as dynamic;
      onSuccess(ToolCollectionModel.fromMap(_results as Map<String, dynamic>));
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
    required Function(List<ToolCollectionModel> event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    String _uri = '${EndPoints.toolCollection}/paginate?page=$page&limit=$limit'
        .toString();

    // add condition filter
    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri =
          '${EndPoints.toolCollection}/paginate?page=$page&limit=$limit$filter';
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
      final _results = response.data['_results'] as List<dynamic>;
      onSuccess(_results
          .map((e) => ToolCollectionModel.fromMap(e as Map<String, dynamic>))
          .toList());
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
    required Function(ToolCollectionModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String _uri = '${EndPoints.toolCollection}/$id';
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
      final _results = response.data as dynamic;
      onSuccess(ToolCollectionModel.fromMap(_results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Tool generator.
  ///
  Future<void> toolGenerator({
    required String toolKey,
    required String toolId,
    required String message,
    required Function(String data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final Map<String, dynamic> _data = {
      'toolKey': toolKey,
      'toolId': toolId,
      'message': message,
      'userId': sl<SharedPreferenceHelper>().getIdUser,
    };

    late Response response;

    try {
      response = await _dio.post(EndPoints.toolGenerator, data: _data);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final _results = response.data as dynamic;

      onSuccess(_results['reply']);
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
