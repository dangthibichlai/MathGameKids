import 'package:url_launcher/url_launcher.dart';

mixin UrlHelper {
  static void call(String phoneNumber) {
    final Uri telLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    launchUrl(telLaunchUri);
  }
}
