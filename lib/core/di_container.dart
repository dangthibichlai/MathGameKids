import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/core/services/google_admod_services/key_validate_ads.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/core/services/notification_services/local_notification_service.dart';
import 'package:template/core/services/socket_io/socket_io.dart';
import 'package:template/data/repositories/feedback_repositories.dart';
import 'package:template/data/repositories/in_app_api.dart';
import 'package:template/data/repositories/setting_repositories.dart';
import 'package:template/data/repositories/tool_collection_repositories.dart';
import 'shared_pref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<KeyValidateAds>(KeyValidateAds());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());

  /// Local Notification.
  sl.registerSingleton<LocalNotificationAPI>(LocalNotificationAPI());

  /// Image upload.
  sl.registerLazySingleton(() => ImageUploadRepository());

  sl.registerLazySingleton(() => Connectivity());

  print('TechMind01');
  // Key validate.

  print('TechMind02');

  // Core
  sl.registerSingleton<DioClient>(DioClient());

  // Socket IO.
  sl.registerLazySingleton<SocketIO>(() => SocketIO());

  // Auth.
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository());

  // Character.
  sl.registerLazySingleton<CharacterRepository>(() => CharacterRepository());

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
}
