// ignore: avoid_classes_with_only_static_members
///
/// Validation
///
// ignore_for_file: parameter_assignments

class IZIValidate {
  ///
  /// check password if return string is has error else null not erorr
  ///
  static String? password(String password) {
    if (password.length < 6) return 'Must have at least 6 characters';
    // if (!password.contains(RegExp("[a-z]"))) {
    //   return 'Phải có ít nhất 1 kí tự in thường';
    // }
    // if (!password.contains(RegExp("[A-Z]"))) {
    //   return 'Phải có ít nhất 1 kí tự in hoa';
    // }
    // if (!password.contains(RegExp("[0-9]"))) return 'Phải có ít nhất 1 số';
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Phải có ít nhất 1 kí tự đặc biệt';
    // }
    return null;
  }

  ///
  /// Validate email
  ///
  static String? email(String text) {
    // a-zA-Z0-9 : allow a - Z 0 -9
    // + @(Bắt buộc )
    if (IZIValidate.nullOrEmpty(text)) {
      return "Vui lòng nhập địa chỉ email";
    }
    if (text.trim().toString() == "") {
      return "";
    }
    final RegExp reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(text)) {
      // email hợp lệ
      return null;
    } else {
      // không hợp lệ
      return "Địa chỉ email không hợp lệ";
    }
  }

  ///
  /// Validate phone
  ///
  static String? phone(String text) {
    //r'^([+0]9)?[0-9]{10}$'
    // final RegExp reg = RegExp(r'([+0])\d{9}$');
    // if (reg.hasMatch(text)) {
    //   // phone validate
    //   return null;
    // } else {
    //   // phone not validate
    //   return "Phone number invalid";
    // }
    if (!IZIValidate.nullOrEmpty(text)) {
      // phone validate
      return null;
    } else {
      return '';
    }
  }

  ///
  /// Tax code
  ///
  static bool taxNum(String value) {
    if (IZIValidate.nullOrEmpty(value) || value == 0.toString()) {
      return false;
    }
    if (value.trim().toString() == "") {
      return true;
    }
    final RegExp reg = RegExp(r'^[0-9]*$');
    if (nullOrEmpty(value)) {
      return false;
    } else if (reg.hasMatch(value)) {
      return true;
    }
    return false;
  }

  ///
  /// empty
  ///
  static String? empty(String text, {int? rangeFrom, int? rangeTo}) {
    if (text.isEmpty) {
      return "Tên không được để trống";
    }
    if (!IZIValidate.nullOrEmpty(rangeFrom)) {
      if (text.length < rangeFrom!) {
        return "Tên ít nhất phải $rangeFrom ký tự";
      }
    }
    if (!IZIValidate.nullOrEmpty(rangeTo)) {
      if (text.length > rangeTo!) {
        return "Tên không được quá $rangeFrom ký tự";
      }
    }
    return null;
  }

  ///
  /// empty
  ///
  static String? increment(String? number) {
    if (IZIValidate.nullOrEmpty(number)) {
      number = '';
    }
    if (int.parse(number!) <= 0) {
      return "Số lượng không được bé hơn 0";
    } else if (int.parse(number) >= 999) {
      return "Số lượng không được lớn hơn 999";
    }
    return null;
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool nullOrEmpty(dynamic value) {
    if (value == null ||
        value.toString().trim().isEmpty ||
        value.toString() == 'null' ||
        value.toString() == '{}' ||
        (value is List && value.isEmpty == true)) return true;
    return false;
  }

  static String getGenderString(dynamic value) {
    if (nullOrEmpty(value) == true) return 'Không xác định';

    if (value == 1 || value == '1') {
      return "Nam";
    } else if (value == 2 || value == '2') {
      return "Nữ";
    } else if (value == 2 || value == '3') {
      return "Tất cả";
    }
    return 'Không xác định';
  }

  static String getRoleString(dynamic value) {
    if (nullOrEmpty(value) == true) return 'Không xác định';

    if (value == 0 || value == '0') {
      return "Khách hàng";
    } else if (value == 1 || value == '1') {
      return "Shipper";
    } else if (value == 2 || value == '2') {
      return "Shop";
    }
    return 'Không xác định';
  }

  static String getGenderValue(dynamic value) {
    if (nullOrEmpty(value) == true) return '3';

    if (value.runtimeType == String) {
      if (value.toString().contains('Nam')) {
        return "1";
      } else if (value.toString().contains('Nữ')) {
        return "2";
      }
      return '3';
    }
    return '3';
  }

  static String getGenderValueCreateQuestion(dynamic value) {
    if (nullOrEmpty(value) == true) return 'ORTHER';

    if (value.runtimeType == String) {
      if (value.toString().contains('MALE')) {
        return 'Male';
      } else if (value.toString().contains('FEMALE')) {
        return 'Female';
      }
      return 'Orther';
    }
    return 'Orther';
  }

  ///
  /// Check is number.
  ///
  static bool isNumeric(String s) {
    if (s == 'null') {
      return false;
    }

    return double.tryParse(s) != null || int.tryParse(s) != null;
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool phoneNumber(String? value) {
    final RegExp reg = RegExp(r'^0[0-9]{9}$');
    if (nullOrEmpty(value)) {
      return false;
    }
    if (reg.hasMatch(value!)) {
      // phone validate
      return true;
    }

    return false;
  }

  ///
  /// Validate special characters.
  ///
  static bool hasSpecialCharacters(String input) {
    final pattern = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return pattern.hasMatch(input);
  }
}
