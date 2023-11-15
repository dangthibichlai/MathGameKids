import 'package:tiengviet/tiengviet.dart';

String toSlug({required String text}) {
  final textSlug = TiengViet.parse(text.toLowerCase()).replaceAll(' ', '-');
  return textSlug;
}
