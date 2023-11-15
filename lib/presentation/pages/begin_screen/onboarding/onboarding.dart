import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/begin_screen/onboarding/UI_model.dart';

class Onboarding extends StatelessWidget {
  const Onboarding(this.pageViewModel);
  final PageViewModel pageViewModel;
  // final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: IZISizeUtil.getMaxWidth(),
          height: IZISizeUtil.getMaxHeight(),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: pageViewModel.backgroundColor ?? ColorResources.WHITE,
            image: pageViewModel.backgroundImage != null
                ? DecorationImage(
                    image: AssetImage(pageViewModel.backgroundImage!),
                    fit: BoxFit.fill,
                  )
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: IZISizeUtil.setSize(percent: .15),
                left: IZISizeUtil.setSizeWithWidth(percent: .08),
                child: Container(
                  width: IZISizeUtil.setSizeWithWidth(percent: .85),
                  constraints: BoxConstraints(
                    maxHeight: IZISizeUtil.setSize(percent: .13),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: IZISizeUtil.setSize(percent: .08),
                        child: Text(
                          pageViewModel.title ?? '',
                          style: TextStyle(
                            color: ColorResources.TEXTONBOAR,
                            fontSize: IZISizeUtil.DISPLAY_MEDIUM_FONT_SIZE,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.65,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        pageViewModel.subtitle ?? '',
                        style: GoogleFonts.nunitoSans(
                          fontSize: IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
                          fontWeight: FontWeight.w800,
                          color: ColorResources.TEXTONBOAR,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   left: IZISizeUtil.setSizeWithWidth(percent: .08),
              //   bottom: IZISizeUtil.setSize(percent: .22),
              //   child: SizedBox(
              //     width: IZISizeUtil.setSizeWithWidth(percent: .7),
              //     child: Text(
              //       pageViewModel.title ?? '',
              //       style: TextStyle(
              //         color: ColorResources.TEXTONBOAR,
              //         fontSize: IZISizeUtil.DISPLAY_MEDIUM_FONT_SIZE,
              //         fontFamily: 'Nunito Sans',
              //         fontWeight: FontWeight.w700,
              //         //height: 0.2,
              //         letterSpacing: -0.65,
              //       ),
              //       maxLines: 2,
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: IZISizeUtil.setSizeWithWidth(percent: .08),
              //   bottom: IZISizeUtil.setSize(percent: .15),
              //   child: SizedBox(
              //     width: IZISizeUtil.setSizeWithWidth(percent: .85),
              //     child: Text(
              //       pageViewModel.subtitle ?? '',
              //       style: GoogleFonts.nunitoSans(
              //           fontSize: IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
              //           fontWeight: FontWeight.w800,
              //           color: ColorResources.TEXTONBOAR),
              //       maxLines: 2,
              //     ),
              //   ),
              // ),
              pageViewModel.headerImage ?? const SizedBox(),
              pageViewModel.bodyImage ?? const SizedBox(),
              pageViewModel.headerImage ?? const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
