import 'dart:ui';

class Tile {
  String? expression;
  int? result;
  bool? isFlipped;
  bool? isMatched;
  Color? color;

  Tile(
      {this.expression,
      this.result,
      this.isFlipped,
      this.isMatched,
      this.color});
  // toJson
  Map<String, dynamic> toJson() => {
        'expression': expression,
        'result': result,
        'isFlipped': isFlipped,
        'isMatched': isMatched,
          
      };
}
