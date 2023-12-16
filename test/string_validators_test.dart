import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  group('String Validators', () {
    final requiredValidator = EzValidator<String?>().required().build();
    final optionalValidator =
        EzValidator<String?>(optional: true).required().build();
    final minLengthValidator = EzValidator<String>().minLength(3).build();
    final maxLengthValidator = EzValidator<String>().maxLength(5).build();
    final betweenLengthValidator =
        EzValidator<String>().minLength(3).maxLength(10).build();
    final emailValidator = EzValidator<String>().email().build();
    final urlvalidator = EzValidator<String>().url().build();
    final uuidValidator = EzValidator<String>().uuid().build();
    final ipV6Validator = EzValidator<String>().ipv6().build();
    final ipV4Validator = EzValidator<String>().ip().build();
    final lowerCaseValidator = EzValidator<String>().lowerCase().build();
    final upperCaseValidator = EzValidator<String>().upperCase().build();
    final matchCaseValidator = EzValidator<String>()
        .matches(RegExp(r'.*isi.*', caseSensitive: false))
        .build();

    test('optional Validator', () {
      expect(optionalValidator(null), isNull, reason: 'null value');
      expect(optionalValidator(''), isNull, reason: 'empty value');
      expect(optionalValidator('a'), isNull, reason: 'not null value');
    });
    test('required Validator', () {
      expect(requiredValidator(null), isNotNull, reason: 'null value');
      expect(requiredValidator(''), isNotNull, reason: 'empty value');
      expect(requiredValidator('a'), isNull, reason: 'not null value');
    });
    test('minLength Validator', () {
      expect(minLengthValidator('a'), isNotNull, reason: 'String too short');
      expect(minLengthValidator('ab'), isNotNull, reason: 'String too short');
      expect(minLengthValidator('abc'), isNull, reason: 'String long enough');
      expect(minLengthValidator('SLAYER'), isNull,
          reason: 'String long enough');
    });

    test('maxLength Validator', () {
      expect(maxLengthValidator('iheb'), isNull, reason: 'String short enough');
      expect(maxLengthValidator('SLAYE'), isNull, reason: 'String is perfect');
      expect(maxLengthValidator('SLAY'), isNull, reason: 'String short enough');
      expect(maxLengthValidator('SLA'), isNull, reason: 'String short enough');
      expect(maxLengthValidator('SL'), isNull, reason: 'String short enough');
      expect(maxLengthValidator('S'), isNull, reason: 'String short enough');
      expect(maxLengthValidator(''), isNull, reason: 'String short enough');
      expect(maxLengthValidator('SLAYER!'), isNotNull, reason: 'too long');
      expect(maxLengthValidator('SLAYER!!'), isNotNull, reason: ' too long');
      expect(maxLengthValidator('SLAYER!!!'), isNotNull, reason: ' too long');
      expect(maxLengthValidator('SLAYER!!!!'), isNotNull, reason: ' too long');
      expect(maxLengthValidator('SLAYER!!!!!'), isNotNull, reason: ' too long');
    });

    test('betweenLength Validator', () {
      expect(betweenLengthValidator('a'), isNotNull,
          reason: 'String too short');
      expect(betweenLengthValidator('ab'), isNotNull,
          reason: 'String too short');
      expect(betweenLengthValidator('abc'), isNull,
          reason: 'String long enough');
      expect(betweenLengthValidator('SLAYER'), isNull,
          reason: 'String long enough');
      expect(betweenLengthValidator('SLAYER!'), isNull,
          reason: 'String long enough');
      expect(betweenLengthValidator('SLAYER!!'), isNull,
          reason: 'String long enough');
      expect(betweenLengthValidator('SLAYER!!!'), isNull,
          reason: 'String long enough');
      expect(betweenLengthValidator('SLAYER!!!!'), isNull,
          reason: 'String long enough');
      expect(betweenLengthValidator('SLAYER!!!!!'), isNotNull,
          reason: 'String long enough');
      expect(betweenLengthValidator('SLAYER!!!!!!'), isNotNull,
          reason: 'String too long');
      expect(betweenLengthValidator('SLAYER!!!!!!!'), isNotNull,
          reason: 'String too long');
      expect(betweenLengthValidator('SLAYER!!!!!!!!'), isNotNull,
          reason: 'String too long');
    });

    test('All Email Addresses Are valid', () {
      final validEmails = [
        "johndoe@example.com",
        "jane_doe1234@example.edu",
        "jimmy.smith@email.co.uk",
        "susan99@example.net",
        "info@company.com",
        "sales@example.net",
        "support@techfirm.com",
        "myname@gmail.com",
        "me12345@yahoo.com",
        "myusername@mydomain.org",
      ];
      for (var actual in validEmails) {
        expect(emailValidator(actual), isNull, reason: 'E-mail Valid: $actual');
      }
    });

    test('All Email Addresses Are invalid', () {
      final invalidEmails = [
        "johndoe",
        "jane_doe1234",
        "jimmy.smith",
        "susan99",
        "info",
        "sales",
        "support",
        "myname",
        "me12345",
        "myusername",
      ];
      for (var actual in invalidEmails) {
        expect(emailValidator(actual), isNotNull,
            reason: 'E-mail Invalid: $actual');
      }
    });

    test('All Urls Are invalid', () {
      final List<String> invalidUrls = [
        "http:/example.com",
        "http://example\\.com",
        "http://ex ample.com",
        "http:///example.com",
        "http://[::1]",
      ];
      for (var actual in invalidUrls) {
        expect(urlvalidator(actual), isNotNull, reason: 'Url Invalid: $actual');
      }
    });

    test('All Urls Are Valid', () {
      final validUrls = [
        "http://example.com",
        "http://example.com/",
        "http://example.com/foo/bar",
        "http://example.com/foo/bar/",
        "http://example.com/foo/bar.html",
        "http://example.com/foo/bar.html?foo=bar",
        "http://example.com/foo/bar.html?foo=bar&bar=baz",
        "http://example.com/foo/bar.html?foo=bar&bar=baz#qux",
        "http://example.com/foo/bar.html#qux",
        "http://example.com/foo/bar#qux",
        "http://example.com/foo/bar/",
        "http://example.com/foo/bar",
        "https://note-slayer.com/",
        "https://pub.dev/",
        "https://www.google.com/",
        "https://www.google.com/search?q=ez_validator&oq=ez_validator&aqs=chrome..69i57j0l7.1771j0j7&sourceid=chrome&ie=UTF-8",
      ];
      for (var actual in validUrls) {
        expect(urlvalidator(actual), isNull, reason: 'Url Valid: $actual');
      }
    });
    test('UUID Validator', () {
      expect(uuidValidator(''), isNotNull, reason: 'Invalid UUID');
      expect(
        uuidValidator('8e5285ea-9c09-11ee-8c90-0242ac120002'),
        isNull,
        reason: 'Version 1 UUID',
      );
      expect(
        uuidValidator('979d58e7-16c3-44c7-b219-618af4a83b73'),
        isNull,
        reason: 'Version 4 UUID',
      );
    });

    test('IPv6 Validator', () {
      expect(ipV6Validator(''), isNotNull, reason: 'Invalid IPv6');
      expect(ipV6Validator('::1'), isNull, reason: 'IPv6');
      expect(ipV6Validator('2001:0db8:85a3:0000:0000:8a2e:0370:7334'), isNull,
          reason: 'IPv6');
      expect(ipV6Validator('2001:db8:85a3:0:0:8a2e:370:7334'), isNull,
          reason: 'IPv6');
      expect(ipV6Validator('2001:db8:85a3::8a2e:370:7334'), isNull,
          reason: 'IPv6');
    });

    test('IPv4 Validator', () {
      final list = [
        '159.194.207.138',
        '27.117.232.60',
        '203.151.206.125',
        '1.246.218.135',
        '8.173.106.116',
        '22.17.125.174',
        '33.110.162.96',
        '216.139.244.230',
        '220.135.43.81',
        '81.172.34.135',
      ];
      for (var actual in list) {
        expect(ipV4Validator(actual), isNull, reason: 'IPv4: $actual');
      }
    });

    test('lowerCase Validator', () {
      expect(lowerCaseValidator(''), isNull, reason: 'Empty String');
      expect(lowerCaseValidator('slayer'), isNull, reason: 'lowerCase String');
      expect(lowerCaseValidator('SLAYER'), isNotNull,
          reason: 'upperCase String');
      expect(lowerCaseValidator('Slayer'), isNotNull,
          reason: 'upperCase String');
      expect(lowerCaseValidator('sLaYeR'), isNotNull,
          reason: 'upperCase String');
      expect(lowerCaseValidator('SLAYER!'), isNotNull,
          reason: 'upperCase String');
      expect(lowerCaseValidator('SLAYER!!'), isNotNull,
          reason: 'upperCase String');
      expect(lowerCaseValidator('SLAYER!!!'), isNotNull,
          reason: 'upperCase String');
      expect(lowerCaseValidator('SLAYER!!!!'), isNotNull,
          reason: 'upperCase String');
      expect(lowerCaseValidator('SLAYER!!!!!'), isNotNull,
          reason: 'upperCase String');
    });

    test('upperCase Validator', () {
      expect(upperCaseValidator(''), isNull, reason: 'Empty String');
      expect(upperCaseValidator('SLAYER'), isNull, reason: 'upperCase String');
      expect(upperCaseValidator('slayer'), isNotNull,
          reason: 'lowerCase String');
      expect(upperCaseValidator('Slayer'), isNotNull,
          reason: 'lowerCase String');
      expect(upperCaseValidator('sLaYeR'), isNotNull,
          reason: 'lowerCase String');
      expect(upperCaseValidator('slayer!'), isNotNull,
          reason: 'lowerCase String');
      expect(upperCaseValidator('slayer!!'), isNotNull,
          reason: 'lowerCase String');
      expect(upperCaseValidator('slayer!!!'), isNotNull,
          reason: 'lowerCase String');
      expect(upperCaseValidator('slayer!!!!'), isNotNull,
          reason: 'lowerCase String');
      expect(upperCaseValidator('slayer!!!!!'), isNotNull,
          reason: 'lowerCase String');
    });

    test('matchCase Validator', () {
      expect(matchCaseValidator(''), isNotNull, reason: 'Invalid case');
      expect(matchCaseValidator('iheb'), isNotNull, reason: 'Invalid case');
      expect(matchCaseValidator('TUNISIA'), isNull, reason: 'Valid case');
      expect(matchCaseValidator('7050'), isNotNull, reason: 'Invalid case');
      expect(matchCaseValidator('tunisia'), isNull, reason: 'Valid case');
      expect(matchCaseValidator('X-SLAYER'), isNotNull, reason: 'Invalid case');
    });
  });
}
