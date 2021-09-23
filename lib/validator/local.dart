import 'form_validator_locale.dart';

class Locale implements FormValidatorLocale {
  const Locale();

  @override
  String name() => 'en';

  @override
  String minLength(String v, int n) =>
      'Field must be at least $n characters long';

  @override
  String maxLength(String v, int n) =>
      'Field must be at most $n characters long';

  @override
  String email(String v) => 'Field is not a valid email address';

  @override
  String phoneNumber(String v) => 'Field is not a valid phone number';

  @override
  String required() => 'Field is required';

  @override
  String ip(String v) => 'Field is not a valid IP address';

  @override
  String ipv6(String v) => 'Field is not a valid IPv6 address';

  @override
  String url(String v) => 'Field is not a valid URL address';

  @override
  String boolean(String v) => 'Field is not a boolean type';

  @override
  String uuid(String v) => 'Field is not a valid uuid';

  @override
  String lowerCase(String v) => 'Field is not in lower case';

  @override
  String upperCase(String v) => 'Field is not in upper case';

  @override
  String max(String v, int n) => '$v must be less than or equal to $n';

  @override
  String min(String v, int n) => '$v must be greater than or equal to $n';

  @override
  String oneOf(List<String?> items, String v) =>
      '$v must be one of the following values: ${items.join(',')}';

  @override
  String notOneOf(List<String?> items, String v) =>
      '$v must not be one of the following value: ${items.join(',')}';
}
