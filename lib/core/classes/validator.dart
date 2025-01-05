import 'package:get/get.dart';

class MyValidator {
  static String? validate(
    String? value, {
    required ValidatorType type,
    String fieldName = 'This field',
    int? min,
    int? max,
    bool required = true,
  }) {
    value = value ?? "";
    if (required && value.trim().isEmpty) {
      return "$fieldName is required.";
    }

    switch (type) {
      case ValidatorType.text:
        // if (!GetUtils.isTxt(value)) {
        //   return "$fieldName must be valid text.";
        // }
        break;

      case ValidatorType.email:
        if (!GetUtils.isEmail(value)) {
          return "$fieldName must be a valid email address.";
        }
        break;

      case ValidatorType.phone:
        if (!GetUtils.isPhoneNumber(value)) {
          return "$fieldName must be a valid phone number.";
        }
        break;

      case ValidatorType.password:

        // if (!RegExp(r'[A-Z]').hasMatch(value)) {
        //   return "$fieldName must contain at least one uppercase letter.";
        // }
        // if (!RegExp(r'[a-z]').hasMatch(value)) {
        //   return "$fieldName must contain at least one lowercase letter.";
        // }
        // if (!RegExp(r'[0-9]').hasMatch(value)) {
        //   return "$fieldName must contain at least one digit.";
        // }
        // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        //   return "$fieldName must contain at least one special character.";
        // }
        break;

      case ValidatorType.number:
        if (!GetUtils.isNumericOnly(value)) {
          return "$fieldName must contain only numbers.";
        }
        break;

      case ValidatorType.price:
        if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
          return "$fieldName must be a valid price.";
        }
        break;

      case ValidatorType.count:
        if (!GetUtils.isNumericOnly(value) || int.tryParse(value) == null) {
          return "$fieldName must be a valid count.";
        }
        break;

      case ValidatorType.url:
        if (!GetUtils.isURL(value)) {
          return "$fieldName must be a valid URL.";
        }
        break;

      case ValidatorType.description:
        if (value.length < 10) {
          return "$fieldName must be at least 10 characters long.";
        }
        break;

      case ValidatorType.date:
        if (!GetUtils.isDateTime(value)) {
          return "$fieldName must be a valid date.";
        }
        break;

      case ValidatorType.time:
        if (!RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(value)) {
          return "$fieldName must be a valid time (HH:mm).";
        }
        break;
      case ValidatorType.dropdown:
        return null;
      // break;
    }

    if (min != null && value.trim().length < min) {
      return "$fieldName must be at least $min characters long.";
    }

    if (max != null && value.trim().length > max) {
      return "$fieldName must be at most $max characters long.";
    }

    return null;
  }
}

enum ValidatorType {
  text, // نصوص عامة
  email, // البريد الإلكتروني
  phone, // أرقام الهواتف
  password, // كلمات المرور
  number, // أرقام فقط
  price, // أسعار
  count, // الأعداد
  url, // الروابط
  description, // الوصف
  date, // التاريخ
  time, // الوقت
  dropdown, // الوقت
}
