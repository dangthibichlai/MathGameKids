import 'dart:math';

class DecimalModel {
  int naturalNumber;
  int decimalNumber;
  DecimalModel({required this.naturalNumber, required this.decimalNumber});
  // random decimal number
  DecimalModel createRandomDecimal(int level, int levelAdd) {
    final Random random = Random();
    naturalNumber = random.nextInt(level) + levelAdd;
    decimalNumber = random.nextInt(level) + levelAdd;
    return DecimalModel(
        naturalNumber: naturalNumber, decimalNumber: decimalNumber);
  }

  // random decimal number for addition
// cộng hai số thập phân
  DecimalModel operator +(DecimalModel decimalModel) {
    int naturalNumber = this.naturalNumber + decimalModel.naturalNumber;
    int decimalNumber = this.decimalNumber + decimalModel.decimalNumber;
    // cộng đơn vị thập phân nếu phần thập phân lớn hơn 10
    if (decimalNumber >= 10) {
      naturalNumber += 1;
      decimalNumber -= 10;
    }
    return DecimalModel(
        naturalNumber: naturalNumber, decimalNumber: decimalNumber);
  }

  // trừ hai số thập phân
  // trừ hai số thập phân
  DecimalModel operator -(DecimalModel decimalModel) {
    int naturalNumber = this.naturalNumber - decimalModel.naturalNumber;
    int decimalNumber = this.decimalNumber - decimalModel.decimalNumber;

    // trừ đơn vị thập phân nếu phần thập phân âm
    if (decimalNumber < 0) {
      naturalNumber -= 1;
      decimalNumber += 10;
    }

    return DecimalModel(
      naturalNumber: naturalNumber,
      decimalNumber: decimalNumber,
    );
  }

// so sánh hai số thập phân
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DecimalModel &&
        other.naturalNumber == naturalNumber &&
        other.decimalNumber == decimalNumber;
  }

  @override
  int get hashCode =>
      naturalNumber.hashCode ^ decimalNumber.hashCode; 
  // kiemr tra số thứ nhất có bé hơn số thứ hai không nếu có hoán đổi vị trí
  bool checkNumber(DecimalModel decimalModel) {
    if (naturalNumber < decimalModel.naturalNumber) {
      return true;
    } else if (naturalNumber == decimalModel.naturalNumber) {
      if (decimalNumber < decimalModel.decimalNumber) {
        return true;
      }
    }
    return false;
  }
  //// hashcode dùng
}
