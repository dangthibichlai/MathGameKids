import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class DropDownButton<T> extends StatefulWidget {
  const DropDownButton({
    Key? key,
    this.hint = "",
    this.onChanged,
    this.data,
    this.width,
    this.height,
    required this.value,
    this.label,
    this.labelStyle,
    required this.isRequired,
    this.isEnable = true,
    this.isSort = true,
    this.padding,
    this.margin,
    this.textStyleValue,
    this.borderRadius,
    this.colorBorder,
    this.backgroundColor,
    this.iconDropdown,
    this.textStyleHintText,
    this.selectedItemBuilder,
    this.prefixWidget,
    this.alignmentText,
    this.onTap,
  }) : super(key: key);

  final String? hint;
  final double? width, height;
  final Function(T? value)? onChanged;
  final VoidCallback? onTap;
  final String? label;
  final TextStyle? labelStyle;
  final bool? isRequired;
  final List<T>? data;
  final T? value;
  final Icon? iconDropdown;
  final bool? isEnable;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool? isSort;
  final TextStyle? textStyleValue;
  final TextStyle? textStyleHintText;
  final double? borderRadius;
  final Color? colorBorder;
  final Color? backgroundColor;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final Widget Function(T value)? prefixWidget;
  final Alignment? alignmentText;

  @override
  State<DropDownButton<T>> createState() => _DropDownButtonState<T>();
}

class _DropDownButtonState<T> extends State<DropDownButton<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? IZISizeUtil.getMaxWidth(),
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          if (widget.label != null)
            Container(
              padding: IZISizeUtil.setEdgeInsetsOnly(bottom: 5),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: widget.labelStyle ??
                      Theme.of(context).textTheme.labelMedium,
                  children: [
                    if (widget.isRequired!)
                      TextSpan(
                          text: ' *',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: ColorResources.RED))
                    else
                      const TextSpan(),
                  ],
                ),
              ),
            ),
          SizedBox(
            height: widget.height,
            child: FormField(
              enabled: widget.isEnable!,
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: widget.margin,
                    border: OutlineInputBorder(
                      borderRadius: IZISizeUtil.setBorderRadiusAll(
                          radius:
                              widget.borderRadius ?? IZISizeUtil.RADIUS_MEDIUM),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: IZISizeUtil.setBorderRadiusAll(
                          radius:
                              widget.borderRadius ?? IZISizeUtil.RADIUS_MEDIUM),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: IZISizeUtil.setBorderRadiusAll(
                          radius:
                              widget.borderRadius ?? IZISizeUtil.RADIUS_MEDIUM),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: IZISizeUtil.setBorderRadiusAll(
                          radius:
                              widget.borderRadius ?? IZISizeUtil.RADIUS_MEDIUM),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor:
                        widget.backgroundColor ?? ColorResources.BACK_GROUND,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      borderRadius: IZISizeUtil.setBorderRadiusAll(
                          radius: widget.borderRadius ?? IZISizeUtil.RADIUS_1X),
                      icon: widget.iconDropdown ?? const SizedBox.shrink(),
                      autofocus: true,
                      onTap: widget.onTap,
                      hint: Text(
                        widget.hint!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: widget.textStyleHintText,
                      ),
                      value: widget.value,
                      selectedItemBuilder: widget.selectedItemBuilder,
                      style: widget.textStyleValue ??
                          Theme.of(context).textTheme.displayLarge,
                      // isDense: true,
                      isExpanded: true,
                      alignment: Alignment.centerLeft,

                      onChanged: widget.isEnable!
                          ? (val) {
                              widget.onChanged?.call(val);
                            }
                          : null,
                      // onInitItems: widget.onInit == null
                      //     ? null
                      //     : () async {
                      //         final List<T> loadedItems =
                      //             await widget.onInit!();

                      //         return loadedItems.map(
                      //           (e) {
                      //             return CommonDropdownMenuItem<T>(
                      //               alignment: widget.alignmentText ??
                      //                   Alignment.centerLeft,
                      //               value: e,
                      //               child: widget.prefixWidget != null
                      //                   ? widget.prefixWidget!(e)
                      //                   : Text(
                      //                       e.toString(),
                      //                       textAlign: TextAlign.center,
                      //                       maxLines: 3,
                      //                       style: widget.textStyleValue ??
                      //                           Theme.of(context)
                      //                               .textTheme
                      //                               .bodyMedium!
                      //                               .copyWith(
                      //                                 color: widget.value
                      //                                             .hashCode ==
                      //                                         e.hashCode
                      //                                     ? ColorResources
                      //                                         .NEUTRALS_2
                      //                                     : ColorResources
                      //                                         .OUTER_SPACE,
                      //                                 fontWeight: widget.value
                      //                                             .hashCode ==
                      //                                         e.hashCode
                      //                                     ? FontWeight.w400
                      //                                     : FontWeight.w400,
                      //                               ),
                      //                       overflow: TextOverflow.ellipsis,
                      //                     ),
                      //             );
                      //           },
                      //         ).toList();
                      //       },
                      items: widget.data
                          ?.map(
                            (e) => DropdownMenuItem<T>(
                              alignment:
                                  widget.alignmentText ?? Alignment.centerLeft,
                              value: e,
                              child: widget.prefixWidget != null
                                  ? widget.prefixWidget!(e)
                                  : Text(
                                      e.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      style: widget.textStyleValue ??
                                          Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: widget.value.hashCode ==
                                                        e.hashCode
                                                    ? ColorResources.NEUTRALS_2
                                                    : ColorResources
                                                        .OUTER_SPACE,
                                                fontWeight:
                                                    widget.value.hashCode ==
                                                            e.hashCode
                                                        ? FontWeight.w400
                                                        : FontWeight.w400,
                                              ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
