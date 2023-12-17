import 'ez_validator_locale.dart';

class DefaultLocale implements EzLocale {
  const DefaultLocale();

  @override
  String name() => 'en';

  @override
  String minLength(String v, int n, [String? label]) =>
      '${label ?? 'The field'} must be at least $n characters long';

  @override
  String maxLength(String v, int n, [String? label]) =>
      '${label ?? 'The field'} must be at most $n characters long';

  @override
  String email(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid email address';

  @override
  String phoneNumber(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid phone number';

  @override
  String required([String? label]) => '${label ?? 'The field'} is required';

  @override
  String ip(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid IP address';

  @override
  String ipv6(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid IPv6 address';

  @override
  String url(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid URL address';

  @override
  String boolean(String v, [String? label]) =>
      '${label ?? 'The field'} is not a boolean type';

  @override
  String uuid(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid uuid';

  @override
  String lowerCase(String v, [String? label]) =>
      '${label ?? 'The field'} is not in lower case';

  @override
  String upperCase(String v, [String? label]) =>
      '${label ?? 'The field'} is not in upper case';

  @override
  String max(String v, num n, [String? label]) =>
      '${label ?? 'The field'} must be less than or equal to $n';

  @override
  String min(String v, num n, [String? label]) =>
      '${label ?? 'The field'} must be greater than or equal to $n';

  @override
  String oneOf(List<dynamic> items, String v, [String? label]) =>
      '${label ?? 'The field'} must be one of the following values: ${items.join(',')}';

  @override
  String notOneOf(List<dynamic> items, String v, [String? label]) =>
      '${label ?? 'The field'} must not be one of the following value: ${items.join(',')}';

  @override
  String notNumber(String v, [String? label]) =>
      '${label ?? 'The field'} must not be a number';

  @override
  String number(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid number';

  @override
  String isInt(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid number';

  @override
  String isDouble(String v, [String? label]) =>
      '${label ?? 'The field'} is not a valid number';

  @override
  String matches(String pattern, String v, [String? label]) =>
      "${label ?? 'The field'} must match the following: $pattern";

  @override
  String date(String v, [String? label]) =>
      "${label ?? 'The field'} must be a date type";

  @override
  String dateMin(String v, DateTime min, [String? label]) =>
      "${label ?? 'The field'} must be greater than or equal to ${min.toIso8601String()}";

  @override
  String dateMax(String v, DateTime min, [String? label]) =>
      "${label ?? 'The field'} must be less than or equal to ${min.toIso8601String()}";

  @override
  String negative(String v, [String? label]) =>
      "${label ?? 'The field'} must be a negative number";

  @override
  String positive(String v, [String? label]) =>
      "${label ?? 'The field'} must be a positive number";

  @override
  String listOf(dynamic v, [String? label]) =>
      "${label ?? 'The field'} must be a list of $v";

  @override
  String isTypeOf(v, [String? label]) =>
      "${label ?? 'The field'} must be a $v type";
}
