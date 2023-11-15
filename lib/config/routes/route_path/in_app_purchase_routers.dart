import 'package:get/get.dart';
import 'package:template/presentation/pages/feedback/feedback_binding.dart';
import 'package:template/presentation/pages/feedback/feedback_page.dart';
import 'package:template/presentation/pages/privacy_policy_package/privacy_policy_binding.dart';
import 'package:template/presentation/pages/privacy_policy_package/privacy_policy_page.dart';
import 'package:template/presentation/pages/term_of_user/term_of_user_binding.dart';
import 'package:template/presentation/pages/term_of_user/term_of_user_page.dart';

import '../../../presentation/pages/change_language/change_language_binding.dart';
import '../../../presentation/pages/change_language/change_language_page.dart';

mixin InAppPurchaseRouters {
  static const String TERM_OF_USER = '/term_of_user';
  static const String PRIVACY_POLICY = '/privacy_policy';
  static const String CHANGE_LANGUAGE = '/change_language';
  static const String FEEDBACK = '/feedback';

  static List<GetPage> listPage = [
    GetPage(
      name: TERM_OF_USER,
      page: () => TermOfUserPage(),
      binding: TermOfUserBinding(),
    ),
    GetPage(
      name: PRIVACY_POLICY,
      page: () => PrivacyPolicyPage(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: CHANGE_LANGUAGE,
      page: () => ChangeLanguagePage(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: FEEDBACK,
      page: () => FeedbackPage(),
      binding: FeedbackBinding(),
    ),
  ];
}
