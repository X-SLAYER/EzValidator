abstract class EzLocale {
  String name();
  String required([String? label]);
  String minLength(String v, int n, [String? label]);
  String min(String v, int n, [String? label]);
  String max(String v, int n, [String? label]);
  String positive(String v, [String? label]);
  String negative(String v, [String? label]);
  String maxLength(String v, int n, [String? label]);
  String email(String v, [String? label]);
  String phoneNumber(String v, [String? label]);
  String ip(String v, [String? label]);
  String ipv6(String v, [String? label]);
  String url(String v, [String? label]);
  String boolean(String v, [String? label]);
  String number(String v, [String? label]);
  String notNumber(String v, [String? label]);
  String uuid(String v, [String? label]);
  String lowerCase(String v, [String? label]);
  String upperCase(String v, [String? label]);
  String date(String v, [String? label]);
  String oneOf(List<String?> items, String v, [String? label]);
  String notOneOf(List<String?> items, String v, [String? label]);
  String matches(String regex, String v, [String? label]);
}
