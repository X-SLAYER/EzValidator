import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

import 'common/fr_locale.dart';

void main() {
  group('Test Schema with locales', () {
    EzValidator.setLocale(const FrLocale());

    final EzSchema schema = EzSchema.shape(
      {
        'email': EzValidator<String>().required().email(),
        'password': EzValidator<String>().required(),
      },
      noUnknown: true,
      fillSchema: false,
    );

    test('Error message should be in french', () {
      final Map<String, dynamic> formData = {
        'email': 'test@email.com',
        'password': 'password',
        'age': 25,
      };
      final (_, errors) = schema.validateSync(formData);
      expect(errors['age'], equals('n\'est pas défini dans le schéma'));
    });

    test('mail error message should be in french', () {
      final Map<String, dynamic> formData = {
        'email': 'testemail.com',
        'password': 'password',
      };
      final (_, errors) = schema.validateSync(formData);
      expect(errors['email'], contains('n\'est pas une adresse e-mail valide'));
    });

    test('Current locale should be fr', () {
      expect(EzValidator.globalLocale.name, equals('fr'));
    });
  });
}
