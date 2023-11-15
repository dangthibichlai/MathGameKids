import 'package:get/get.dart';
import 'package:template/core/utils/images_path.dart';

class AlgebraController extends GetxController {
  // listFunction là danh sách các phép tính
  List<Map<String, String>> listFunction = [
    {
      ' text': 'select_game_1'.tr,
      'urlImage': ImagesPath.practiceIcon,
    },
    {
      ' text': 'select_game_2'.tr,
      'urlImage': ImagesPath.quizIcon,
    },
    {
      ' text': 'select_game_3'.tr,
      'urlImage': ImagesPath.multiplayerIcon,
    },
    {
      ' text': 'select_game_4'.tr,
      'urlImage': ImagesPath.misingNumberIcon,
    },
  ];
}
