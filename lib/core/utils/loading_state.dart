// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/loading/izi_loading_card.dart';
import 'package:template/core/helper/izi_size_util.dart';

import 'color_resources.dart';
import 'internet_connection.dart';

mixin LoadingState<T> on StateMixin<T> {
  Widget buildObx(
    NotifierBuilder<T?> widget, {
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
    Widget? onNotInternet,
    CONNECTION_STATUS connectionStatus = CONNECTION_STATUS.CONNECTED,
  }) {
    return connectionStatus == CONNECTION_STATUS.DISCONNECTED
        ? onNotInternet ??
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(
                    radius: 30,
                  ),
                  const SizedBox(
                    height: IZISizeUtil.SPACE_COMPONENT,
                  ),
                  Text(
                    "Không có kết nối internet.\nVui lòng kiểm tra lại",
                    textAlign: TextAlign.center,
                    style:
                        Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorResources.OUTER_SPACE,
                            ),
                  ),
                ],
              ),
            )
        : SimpleBuilder(
            builder: (_) {
              if (status.isLoading) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: onLoading ??
                      const CardLoadingItem(
                        count: 8,
                      ),
                );
              } else if (status.isError) {
                return onError != null
                    ? onError(status.errorMessage)
                    : Center(child: Text('${status.errorMessage}'));
              } else if (status.isEmpty) {
                return onEmpty ??
                    const Center(
                      child: Text("Không có dữ liệu"),
                    );
              } else if (status.isLoadingMore) {
                return const SizedBox();
              }
              return widget(value);
            },
          );
  }
}
