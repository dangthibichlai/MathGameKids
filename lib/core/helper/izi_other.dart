import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

mixin IZIOther {
  ///
  /// Get file size.
  ///
  static Future<String> getFileSize(String filepath, {int? decimals = 2}) async {
    final file = File(filepath);
    final int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals!)} ${suffixes[i]}';
  }

  ///
  /// Download file.
  ///
  static Future<String?> downLoadFile({required String urlFile}) async {
    final Dio _dio = Dio();
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${appDocumentsDirectory.path}/AudioDownload${DateTime.now().microsecondsSinceEpoch}.mp3';

    try {
      await _dio.download(urlFile, filePath);

      print('File downloaded to: $filePath');

      return filePath;
    } catch (e) {
      print('Download error: $e');
    }
    return null;
  }

  ///
  /// Fix image Orientation.
  ///
  static Future<File> fixImageOrientation(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);

    img.Image fixedImage;
    if (image!.width > image.height) {
      fixedImage = img.copyRotate(image, angle: -90);
    } else {
      fixedImage = img.copyRotate(image, angle: 0);
    }

    final fixedImageFile = File(imageFile.path);
    fixedImageFile.writeAsBytesSync(img.encodeJpg(fixedImage));
    return fixedImageFile;
  }

  ///
  /// Get duration video.
  ///
  // static Future<Duration> getVideoDuration(String videoPath) async {
  //   final VideoPlayerController controller = VideoPlayerController.file(File(videoPath));
  //   await controller.initialize();
  //   final Duration duration = controller.value.duration;
  //   await controller.dispose();
  //   return duration;
  // }

  ///
  /// Convert duration to full time.
  ///
  static String convertDurationToToTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
