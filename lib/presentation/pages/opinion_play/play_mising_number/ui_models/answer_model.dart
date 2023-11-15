class AnswerModel {
  final int value;
  final bool isCorrect;
  bool isSelected;

  bool get hasChooseRight => isCorrect && isSelected;

  AnswerModel({required this.value, this.isCorrect = false, this.isSelected = false});
}
