// ignore_for_file: join_return_with_assignment

import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:tiengviet/tiengviet.dart';

///
/// handler string
///
class IZIString {
  static String cut(String text, {int length = 50}) {
    String content = text;
    if (text.length > length) {
      content = '${text.substring(0, length)}...';
      return content;
    }
    return content;
  }

  ///
  /// Dinh dang ten file da upload
  ///
  static String getFileNameFromUrl(String text) {
    if (text.isNotEmpty && text.toString() != 'null') {
      final arrayNameSplit = text.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }

  ///
  /// covert vietnames to Vietnamese tones
  ///
  static String toAscii(String str) {
    final _str = TiengViet.parse(str.toLowerCase()).toLowerCase();
    return _str;
  }

  ///
  /// Get the value price from string
  ///
  static String getNumberString(dynamic value) {
    if (value == null ||
        value.toString().isEmpty ||
        value.toString() == 'null' ||
        (value is List && value.isEmpty == true)) return '0';
    final String result = value
        .toString()
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('null', '');
    if (result == '') return '0';
    return result;
  }

  ///
  ///  A Dart library for unescaping HTML-encoded strings.
  ///
  String htmlUnescape(String htmlString) {
    if (!IZIValidate.nullOrEmpty(htmlString)) {
      final unescape = HtmlUnescape();
      return unescape.convert(htmlString);
    }
    return '';
  }

  static String formatNumberPrice(num value) {
    if (IZIValidate.nullOrEmpty(value)) return '0';
    final formatter = NumberFormat('#,##0', 'en_US');
    final formattedNumber = formatter.format(value);
    return formattedNumber;
  }

  static String formatPriceCompactLong(num value) {
    if (IZIValidate.nullOrEmpty(value)) return '0';

    final formatter = NumberFormat.compactLong(locale: 'vi_VN');
    final formattedNumber = formatter.format(value);
    return formattedNumber;
  }

  static String formatPriceByUI(num value) {
    if (IZIValidate.nullOrEmpty(value)) return '0';

    if (value.toString().length > 9) return formatPriceCompactLong(value);

    return formatNumberPrice(value);
  }
}
