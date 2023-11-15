import 'package:get/get.dart';
import 'package:template/core/utils/images_path.dart';

import '../config/routes/route_path/main_routh.dart';

class Game {
  final String name;
  final String image;
  final String? route;

  Game({required this.name, required this.image, this.route});
}

List<Game> listEight = [
  Game(
    name: 'select_game_1'.tr,
    image: ImagesPath.practiceIcon,
    route: MainRouters.PRACTICE,
  ),
  Game(
    name: 'select_game_2'.tr,
    image: ImagesPath.quizIcon,
    route: MainRouters.QUIZ,
  ),
  Game(
    name: 'select_game_3'.tr,
    image: ImagesPath.multiplayerIcon,
    route: MainRouters.MULTIPLAYER,
  ),
  Game(
    name: 'select_game_4'.tr,
    image: ImagesPath.misingNumberIcon,
    route: MainRouters.MISSINGNUMBER,
  ),
  Game(
    name: 'select_game_5'.tr,
    image: ImagesPath.truephoneIcon,
    route: MainRouters.TRUEFALSE,
  ),
  Game(
    name: 'select_game_6'.tr,
    image: ImagesPath.memoryIcon,
    route: MainRouters.MEMMORY,
  ),
  Game(
    name: 'select_game_7'.tr,
    image: ImagesPath.longAdditionIcon,
    route: MainRouters.LONGADDITION,
  ),
  Game(
    name: 'select_game_8'.tr,
    image: ImagesPath.timeChallenge,
    route: MainRouters.TIMECHALLENGE,
  ),
];

List<Game> listFour = [
  Game(
    name: 'select_four_1'.tr,
    image: ImagesPath.practice_addition,
    route: MainRouters.FRACTICE_PLAY,
  ),
  Game(
    name: 'select_four_2'.tr,
    image: ImagesPath.practiceSubtractionIcon,
    route: MainRouters.FRACTICE_PLAY,
  ),
  Game(
    name: 'select_four_3'.tr,
    image: ImagesPath.practiceMultiplicationIcon,
    route: MainRouters.FRACTICE_PLAY,
  ),
  Game(
    name: 'select_four_4'.tr,
    image: ImagesPath.practiceDivisionIcon,
    route: MainRouters.FRACTICE_PLAY,
  ),
];

List<Game> listFourDecimal = [
  Game(
    name: 'select_four_1'.tr,
    image: ImagesPath.practice_addition,
    route: MainRouters.PLAYDECIMAL,
  ),
  Game(
    name: 'select_four_2'.tr,
    image: ImagesPath.practiceSubtractionIcon,
    route: MainRouters.PLAYDECIMAL,
  ),
  Game(
    name: 'select_game_2'.tr,
    image: ImagesPath.quizIcon,
    route: MainRouters.PLAYDECIMAL,
  ),
  Game(
    name: 'select_game_3'.tr,
    image: ImagesPath.multiplayerIcon,
    route: MainRouters.PLAYDECIMALMULTI,
  ),
];
List<Game> listFourAlgebra = [
  Game(
    name: 'select_four_1'.tr,
    image: ImagesPath.practice_addition,
    route: MainRouters.PLAYALGEBRA,
  ),
  Game(
    name: 'select_four_2'.tr,
    image: ImagesPath.practiceSubtractionIcon,
    route: MainRouters.PLAYALGEBRA,
  ),
  Game(
    name: 'select_four_3'.tr,
    image: ImagesPath.practiceMultiplicationIcon,
    route: MainRouters.PLAYALGEBRA,
  ),
  Game(
    name: 'select_four_4'.tr,
    image: ImagesPath.practiceDivisionIcon,
    route: MainRouters.PLAYALGEBRA,
  ),
];

List<Game> listThree = [
  Game(
    name: 'select_game_1'.tr,
    image: ImagesPath.practiceIcon,
    route: MainRouters.PLAYEXPONENTS,
  ),
  Game(
    name: 'select_game_2'.tr,
    image: ImagesPath.quizIcon,
    route: MainRouters.PLAYEXPONENTS,
  ),
  Game(
    name: 'select_game_3'.tr,
    image: ImagesPath.multiplayerIcon,
    route: MainRouters.MULTIEXPONETS,
  ),
];
List<Game> listThreeSquareRoot = [
  Game(
    name: 'select_game_1'.tr,
    image: ImagesPath.practiceIcon,
    route: MainRouters.PLAYSQUAREROOT,
  ),
  Game(
    name: 'select_game_2'.tr,
    image: ImagesPath.quizIcon,
    route: MainRouters.PLAYSQUAREROOT,
  ),
  Game(
    name: 'select_game_3'.tr,
    image: ImagesPath.multiplayerIcon,
    route: MainRouters.MULTISQUARE,
  ),
];
