import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/widgets/text_to_speech_component/generate_dialog.dart';

mixin ShowDialog {
  static Future<void> showGenerateDialog({
    required BuildContext context,
    bool? isGenerateDialog = false,
    bool? isAllowCloseOutSize = true,
    Widget? childWidget,
  }) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        final curve = Curves.easeInOut.transform(a1.value);
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Transform.scale(
            scale: curve,
            child: Dialog.fullscreen(
              backgroundColor: Colors.black.withOpacity(.5),
              child: GestureDetector(
                onTap: isGenerateDialog!
                    ? null
                    : () {
                        if (isAllowCloseOutSize!) {
                          Get.back();
                        }
                      },
                child: Container(
                  width: IZISizeUtil.getMaxWidth(),
                  height: IZISizeUtil.getMaxHeight(),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isGenerateDialog) const GenerateDialog() else childWidget!,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 50),
    );
  }
}
