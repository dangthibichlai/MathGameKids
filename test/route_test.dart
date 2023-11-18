import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/main.dart';
import 'package:template/presentation/pages/begin_screen/onboarding/UI_model.dart';
import 'package:template/presentation/pages/begin_screen/onboarding/onboarding.dart';
import 'package:template/presentation/pages/begin_screen/onboarding/onboarding_controller.dart';

void main() {
  testWidgets('Splash screen navigates to introduce screen',
      (WidgetTester tester) async {
    late PackageDescriptionController packageDescriptionController;
    late PageController _pageController;

    setUp(() => {
          packageDescriptionController = PackageDescriptionController(),
          _pageController = PageController(),
        });
    testWidgets("checking router splash", (widgetTester) async {
      await tester.pumpWidget(const MyApp());

      // Đợi một khoảng thời gian, giả định thời gian chuyển đến trang introduce
      await tester.pump(Duration(seconds: 2));

      // Kiểm tra xem đã chuyển đến trang introduce hay chưa
      expect(
          find.byWidget(PageView.builder(
            controller: _pageController,
            itemCount: payViews.length,
            itemBuilder: (context, index) {
              return Onboarding(
                payViews[index],
              );
            },
          )),
          findsOneWidget);
    });
  });
}
