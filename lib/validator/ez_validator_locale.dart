abstract class FormValidatorLocale {
  String name();
  String required();
  String minLength(String v, int n);
  String min(String v, int n);
  String max(String v, int n);
  String maxLength(String v, int n);
  String email(String v);
  String phoneNumber(String v);
  String ip(String v);
  String ipv6(String v);
  String url(String v);
  String boolean(String v);
  String number(String v);
  String notNumber(String v);
  String uuid(String v);
  String lowerCase(String v);
  String upperCase(String v);
  String oneOf(List<String?> items, String v);
  String notOneOf(List<String?> items, String v);
  String matches(String regex, String v);
}
