import 'package:email_validator/email_validator.dart';

class Validator {
  static const upperCasePattern = r'[A-Z]';
  static const lowerCasePattern = r'[a-z]';
  static const numberPattern = r'[0-9]';
  static const lengthPattern = r'^.{8,}$';
  static const passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';

  static bool isEmpty(final String? string) => (string == null || string.isEmpty);

  static bool isEmailCorrect(final String email) => EmailValidator.validate(email);

  static bool isPasswordCorrect(final String password) => RegExp(passwordPattern).hasMatch(password);

  static bool containsUpperCaseSymbol(final String password) => RegExp(upperCasePattern).hasMatch(password);

  static bool containsLowerCaseSymbol(final String password) => RegExp(lowerCasePattern).hasMatch(password);

  static bool containsDigits(final String password) => RegExp(numberPattern).hasMatch(password);

  static bool hasCorrectLengthDigits(final String password) => RegExp(lengthPattern).hasMatch(password);
}
