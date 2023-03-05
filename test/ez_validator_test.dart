import 'package:ez_validator/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final emailValidator = EzValidator().email().build();
  final urlValidator = EzValidator().url().build();
  final requiredValidator = EzValidator().required().build();
  final minLengthValidator = EzValidator().minLength(3).build();

  final List<String> minLength = [
    'X-SLAYER',
    'iheb',
    'Pixelium',
  ];

  final List<String?> emptyStrings = [
    null,
    ' ',
    '',
    '          ',
  ];

  final List<String> validAddresses = [
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

  final List<String> invalidUrls = [
    "http:/example.com",
    "http://example\\.com",
    "http://ex ample.com",
    "http:///example.com",
    "http://[::1]",
  ];

  test('Min length are good', () {
    for (var actual in minLength) {
      var result = minLengthValidator(actual);
      expect(result, equals(null), reason: 'Field: $actual');
    }
  });

  test('All Fields are Empty', () {
    for (var actual in emptyStrings) {
      var result = requiredValidator(actual);
      expect(result, isA<String>(), reason: 'Field: $actual');
    }
  });
  test('All Email Addresses Are valid', () {
    for (var actual in validAddresses) {
      var result = emailValidator(actual);
      expect(result, equals(null), reason: 'E-mail: $actual');
    }
  });

  test('All Urls are invalid', () {
    for (var url in invalidUrls) {
      var result = urlValidator(url);
      expect(result, isA<String>(), reason: 'URL: $url');
    }
  });
}
