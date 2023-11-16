import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/services/google_admod_services/key_validate_ads.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/app_binding.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_practice/play_practice_controller.dart';
import 'package:connectivity/connectivity.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/core/services/notification_services/local_notification_service.dart';
import 'package:template/core/services/socket_io/socket_io.dart';
import 'package:template/data/repositories/feedback_repositories.dart';
import 'package:template/data/repositories/in_app_api.dart';
import 'package:template/data/repositories/setting_repositories.dart';
import 'package:template/data/repositories/tool_collection_repositories.dart';

void main() {
  group('PlayPracticeController Tests', () {
    late PlayPracticeController playPracticeController;
    late DashBoardController dashBoardController;

    setUpAll(() async {
      runApp(GetMaterialApp(
        initialRoute: AuthRouter.SPLASH,
        initialBinding: AppBinding(),
        debugShowCheckedModeBanner: false,
      ));
      final sl = GetIt.instance;

      init();
      sl.registerSingleton<SharedPreferences>(
          await SharedPreferences.getInstance());
      sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());

      /// Local Notification.
      sl.registerSingleton<LocalNotificationAPI>(LocalNotificationAPI());

      /// Image upload.
      sl.registerLazySingleton(() => ImageUploadRepository());

      sl.registerLazySingleton(() => Connectivity());

      print('TechMind01');
      // Key validate.
      sl.registerSingleton<KeyValidateAds>(KeyValidateAds());

      print('TechMind02');

      // Core
      sl.registerSingleton<DioClient>(DioClient());

      // Socket IO.
      sl.registerLazySingleton<SocketIO>(() => SocketIO());

      // Auth.
      sl.registerLazySingleton<AuthRepository>(() => AuthRepository());

      // Character.
      sl.registerLazySingleton<CharacterRepository>(
          () => CharacterRepository());

      // Category.
      sl.registerLazySingleton<CategoryRepository>(() => CategoryRepository());

      // Conversation.
      sl.registerLazySingleton<ConversationRepository>(
          () => ConversationRepository());

      // Message.
      sl.registerLazySingleton<MessagesRepository>(() => MessagesRepository());

      // Convert.
      sl.registerLazySingleton<ConvertFileToTextRepository>(
          () => ConvertFileToTextRepository());

      // Settings.
      sl.registerLazySingleton<SettingRepository>(() => SettingRepository());

      // DIY.
      sl.registerLazySingleton<DIYRepository>(() => DIYRepository());

      // Tool collection.
      sl.registerLazySingleton<ToolCollectionRepository>(
          () => ToolCollectionRepository());

      // In App API.
      sl.registerLazySingleton<InAppAPI>(() => InAppAPI());

      // In App API.
      sl.registerLazySingleton<FeedbackRepository>(() => FeedbackRepository());
      sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(
          sl<SharedPreferences>(), sl<SharedPreferences>()));
      sl.registerSingleton<KeyValidateAds>(KeyValidateAds());
      playPracticeController = PlayPracticeController();
      playPracticeController.onInit();
      // final Map<String, dynamic> arguments = Get.arguments;

      dashBoardController = DashBoardController();
    });

    test('Initial values are set correctly', () {
      dashBoardController.onInit();
      expect(playPracticeController.currentQuestion.value, '5 + 8 = ?');
      expect(playPracticeController.correctAnswer, 13);
      expect(playPracticeController.currentOptions.length, 4);
      expect(playPracticeController.isCorrect, true);
      expect(playPracticeController.answerColors, <int, Color>{});
      expect(playPracticeController.count.value, 1);
      expect(playPracticeController.countWrong.value, 0);
      expect(playPracticeController.countCorrect.value, 0);
      expect(playPracticeController.countSkip.value, 0);
      expect(playPracticeController.isShowResult.value, false);
      expect(playPracticeController.level, MATHLEVEL.EASY);
      expect(playPracticeController.route, '');
      expect(playPracticeController.title, '');
      expect(playPracticeController.rangeRandom, 10);
      expect(playPracticeController.textLevel.value, '');
    });

    test('Check if answer is correct', () {
      dashBoardController.onInit();
      playPracticeController.correctAnswer = 10;

      // Simulate selecting the correct answer
      playPracticeController.checkAnswer(10);

      expect(playPracticeController.isCorrect, true);
      expect(playPracticeController.answerColors[10], ColorResources.GREEN);
      expect(playPracticeController.countCorrect.value, 1);
      expect(playPracticeController.count.value, 2);
      expect(playPracticeController.isShowResult.value, false);
    });

    test('Check if answer is incorrect', () {
      dashBoardController.onInit();
      playPracticeController.correctAnswer = 10;

      // Simulate selecting an incorrect answer
      playPracticeController.checkAnswer(5);

      expect(playPracticeController.isCorrect, false);
      expect(playPracticeController.answerColors[5], ColorResources.RED);
      expect(playPracticeController.countWrong.value, 1);
    });

    test('Check level assignment', () {
      dashBoardController.onInit();
      playPracticeController.checkLevel(MATHLEVEL.MEDIUM);

      expect(playPracticeController.textLevel.value, 'medium'.tr);
      expect(
          playPracticeController.rangeRandom, MathLevelValueMax.MEDIUM_VALUE);
    });

    test('Generate question', () {
      dashBoardController.onInit();
      playPracticeController.generateQuestion(10, MainRouters.ADDITION);

      expect(
          playPracticeController.currentOptions
              .contains(playPracticeController.correctAnswer),
          true);
    });
  });
}
