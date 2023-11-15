
// import '../../../../../../models/answer_model.dart';
// import '../../../../../../models/missing_position_model.dart';

import 'package:template/presentation/pages/opinion_play/play_mising_number/ui_models/answer_model.dart';
import 'package:template/presentation/pages/opinion_play/play_mising_number/ui_models/missing_position_model.dart';

enum OperationMathType {
  add,
  subtract,
  multiply,
  divide,
}

class MathModel {
  final int firstNumber;
  final int secondNumber;
  final MissingPositionModel missingPosition;
  final List<AnswerModel> answers;

  final OperationMathType operationMathType;

  int get result {
    switch (operationMathType) {
      case OperationMathType.add:
        return firstNumber + secondNumber;
      case OperationMathType.subtract:
        return firstNumber - secondNumber;
      case OperationMathType.multiply:
        return firstNumber * secondNumber;
      case OperationMathType.divide:
        return firstNumber ~/ secondNumber;
    }
  }

  MathModel({
    required this.firstNumber,
    required this.secondNumber,
    required this.operationMathType,
    required this.missingPosition,
    required this.answers,
  }) : assert(
          answers.length == 4 &&
              answers.where((element) => element.isCorrect).length == 1,
        );
}
