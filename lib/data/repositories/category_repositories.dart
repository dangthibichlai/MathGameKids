import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/domain/export/domain_export.dart';


class CategoryRepository {
  final _dio = GetIt.I.get<DioClient>();

  ///
  /// Get all.
  ///
  Future<void> getAll({
    String? filter,
    required Function(List<CategoriesModel> event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    String _uri = EndPoints.category;

    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri = '${EndPoints.category}?$filter';
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as List<dynamic>;

      onSuccess(results.map((e) => CategoriesModel.fromMap(e as Map<String, dynamic>)).toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Paginate.
  ///
  Future<void> paginate(
    int page,
    int limit, {
    String? filter,
    required Function(List<CategoriesModel> event, int total) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    String _uri = '${EndPoints.category}/paginate?page=$page&limit=$limit'.toString();

    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri = '${EndPoints.category}/paginate?page=$page&limit=$limit$filter';
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data['results'] as List<dynamic>;
      final totalResult = IZINumber.parseInt(response.data['totalResults']);
      onSuccess(results.map((e) => CategoriesModel.fromMap(e as Map<String, dynamic>)).toList(), totalResult);
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
