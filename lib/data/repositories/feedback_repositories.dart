import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:template/data/model/response/feedback_model.dart';
import 'package:template/domain/end_points/end_point.dart';

import '../export/data_export.dart';

class FeedbackRepository {
  final _dio = GetIt.I.get<DioClient>();

  ///
  /// Get setting.
  ///
  Future<void> sendFeedback({
    required FeedbackModel feedbackModel,
    required Function(dynamic event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    const String _uri = EndPoints.feedback;

    try {
      response = await _dio.post(_uri, data: feedbackModel.toJson());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      onSuccess(response.data);
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
