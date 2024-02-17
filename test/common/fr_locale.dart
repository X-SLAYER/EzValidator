import 'package:ez_validator/ez_validator.dart';

class FrLocale implements EzLocale {
  const FrLocale();

  @override
  String get name => 'fr';

  @override
  String get unknownFieldMessage => 'n\'est pas défini dans le schéma';

  @override
  String minLength(String v, int n, [String? label]) =>
      '${label ?? 'Ce champ'} doit contenir au moins $n caractères';
  @override
  String maxLength(String v, int n, [String? label]) =>
      '${label ?? 'Ce champ'} doit contenir au plus $n caractères';
  @override
  String email(String v, [String? label]) =>
      '${label ?? 'Ce champ'} n\'est pas une adresse e-mail valide';

  @override
  String phoneNumber(String v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas un numéro de téléphone valide";

  @override
  String required([String? label]) => '${label ?? 'Ce champ'} est requis';

  @override
  String ip(String v, [String? label]) =>
      '${label ?? 'Ce champ'} n\'est pas une adresse IP valide';

  @override
  String ipv6(String v, [String? label]) =>
      '${label ?? 'Ce champ'} n\'est pas une adresse IPv6 valide';

  @override
  String url(String v, [String? label]) =>
      '${label ?? 'Ce champ'} n\'est pas une adresse URL valide';

  @override
  String boolean(String v, [String? label]) =>
      '${label ?? 'Ce champ'} n\'est pas de type booléen';

  @override
  String uuid(String v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas un uuid valide";

  @override
  String lowerCase(String v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas en minuscule";

  @override
  String upperCase(String v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas en majuscule";

  @override
  String max(String v, num n, [String? label]) =>
      "${label ?? 'Ce champ'} doit être inférieur ou égal à $n";

  @override
  String min(String v, num n, [String? label]) =>
      "${label ?? 'Ce champ'} doit être supérieur ou égal à $n";

  @override
  String oneOf(List<dynamic> items, String v, [String? label]) =>
      "${label ?? 'Ce champ'} doit être l'une des valeurs suivantes : ${items.join(',')}";

  @override
  String notOneOf(List<dynamic> items, String v, [String? label]) =>
      "${label ?? 'Ce champ'} ne doit pas être l'une des valeurs suivantes : ${items.join(',')}";

  @override
  String notNumber(String v, [String? label]) =>
      "${label ?? 'Ce champ'} ne doit pas être un nombre";

  @override
  String number(String v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas un numéro valide";

  @override
  String matches(String pattern, String v, [String? label]) =>
      "${label ?? 'Ce champ'} doit correspondre à ce qui suit : $pattern";

  @override
  String date(String v, [String? label]) =>
      "${label ?? 'Ce champ'} doit être de type date";

  @override
  String dateMin(String v, DateTime min, [String? label]) =>
      "${label ?? 'Ce champ'} doit être supérieur ou égal à ${min.toIso8601String()}";
  @override
  String dateMax(String v, DateTime min, [String? label]) =>
      "${label ?? 'Ce champ'} doit être inférieur ou égal à ${min.toIso8601String()}";

  @override
  String negative(String v, [String? label]) =>
      "${label ?? 'Ce champ'} doit être un nombre négatif";

  @override
  String positive(String v, [String? label]) =>
      "${label ?? 'Ce champ'} doit être un nombre positif";

  @override
  String listOf(dynamic v, [String? label]) =>
      "${label ?? 'Ce champ'} doit être une liste de ${v.runtimeType}";

  @override
  String isDouble(String v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas un nombre valide";

  @override
  String isInt(String v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas un nombre valide";

  @override
  String isTypeOf(v, [String? label]) =>
      "${label ?? 'Ce champ'} n'est pas du type ${v.runtimeType}";
}
