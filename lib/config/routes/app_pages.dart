import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/config/routes/route_path/in_app_purchase_routers.dart';
import 'package:template/config/routes/route_path/main_routh.dart';

import 'route_path/auth_routh.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
    ...MainRouters.listPage,
    ...AuthRouter.listPage,
    ...InAppPurchaseRouters.listPage,
  ];
}
