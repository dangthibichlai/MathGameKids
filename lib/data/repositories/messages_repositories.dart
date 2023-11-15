import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/domain/export/domain_export.dart';

class MessagesRepository {
  final _dio = GetIt.I.get<DioClient>();

  ///
  /// Get all
  ///
  Future<void> getAll({
    required Function(List<MessageModel> event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.messages);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as List<dynamic>;
      onSuccess(results.map((e) => MessageModel.fromMap(e as Map<String, dynamic>)).toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Add
  ///
  Future<void> add({
    required bool isChatWithDIY,
    required MessageModel data,
    required Function(MessageModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    try {
      late String _uri;
      if (isChatWithDIY) {
        _uri = EndPoints.diyChat;
      } else {
        _uri = EndPoints.messages;
      }

      response = await _dio.post(_uri, data: data.toJson());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(MessageModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Update
  ///
  Future<void> update({
    required String id,
    required MessageModel data,
    required Function(MessageModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response = await _dio.put('${EndPoints.messages}/$id', data: data.toMap());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(MessageModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<void> delete({
    required String id,
    required Function(MessageModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response = await _dio.delete('${EndPoints.messages}/$id');
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(MessageModel.fromMap(results as Map<String, dynamic>));
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
    required bool isChatWithDIY,
    required Function(List<MessageModel> event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    late String _uri;
    if (isChatWithDIY) {
      _uri = '${EndPoints.diyChat}/paginate?page=$page&limit=$limit'.toString();

      if (!IZIValidate.nullOrEmpty(filter)) {
        _uri = '${EndPoints.diyChat}/paginate?page=$page&limit=$limit$filter';
      }
    } else {
      _uri = '${EndPoints.messages}/paginate?page=$page&limit=$limit'.toString();

      if (!IZIValidate.nullOrEmpty(filter)) {
        _uri = '${EndPoints.messages}/paginate?page=$page&limit=$limit$filter';
      }
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data['results'] as List<dynamic>;
      onSuccess(results.map((e) => MessageModel.fromMap(e as Map<String, dynamic>)).toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Clear message.
  ///
  Future<void> clearMessage({
    required bool isChatWithDIY,
    required String conversationId,
    required Function(MessageModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    late String _uri;
    if (isChatWithDIY) {
      _uri = '${EndPoints.diyChat}/$conversationId/clear-diy'.toString();
    } else {
      _uri = '${EndPoints.messages}/$conversationId/clear-conversation'.toString();
    }

    try {
      response = await _dio.delete(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(MessageModel.fromMap(results as Map<String, dynamic>));
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
    required Function(MessageModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String _uri = '${EndPoints.messages}/$id';
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
      onSuccess(MessageModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
