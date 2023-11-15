import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/presentation/widgets/bu_start.dart';
import '../../../../core/shared_pref/shared_preference_helper.dart';
import 'onboarding.dart';
import 'UI_model.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _hideStatusBar();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
      if (_currentPage == 1) {
        sl<SharedPreferenceHelper>().setSplash(status: true);
        return;
      }
    });
  }

  void _hideStatusBar() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: payViews.length,
                itemBuilder: (context, index) {
                  return Onboarding(
                    payViews[index],
                  );
                },
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
            ),
            Positioned(
              bottom: IZISizeUtil.setSize(percent: .3),
              left: IZISizeUtil.setSizeWithWidth(percent: .45),
              child: DotsIndicator(
                dotsCount: payViews.length, // Số lượng trang lướt
                position: _currentPage, // Vị trí trang hiện tại
                decorator: DotsDecorator(
                  activeColor: const Color(0xCC15001F),
                  color: const Color(0xCC15001F),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Positioned(
              left: IZISizeUtil.setSizeWithWidth(percent: .08),
              bottom: IZISizeUtil.setSize(percent: .08),
              child: ButtonStart(
                onPressed: () {
                  if (_currentPage == payViews.length - 1) {
                    Navigator.popAndPushNamed(context, AuthRouter.PRENIUM);
                  } else {
                    _pageController.animateToPage(_currentPage + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linear);
                  }
                },
              ),
            ),
            Positioned(
              top: IZISizeUtil.setSize(percent: .02),
              left: IZISizeUtil.setSizeWithWidth(percent: .04),
              child: IconButton(
                onPressed: () {
                  //Get.offName(AuthRouter.PRENIUM);
                  Navigator.popAndPushNamed(context, AuthRouter.PRENIUM);
                },
                icon: Icon(
                  size: 24,
                  Icons.close,
                  color: const Color(0xC9D8D8D8).withOpacity(.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
