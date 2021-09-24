# ez_validator

Dead simple field/object schema validation for flutter </br>
EzValidator api is inspired by [Yup](https://github.com/jquense/yup)

## EzValidator

EzValidator is a flutter schema builder for value validation. Define a schema, validate the shape of an existing value, or both.
EzValidator allow single or object validations

## Usage

You define your schema object.
check the exemple folder of how to use validation with multiple form with showing errors

```dart
EzSchema mySchema = EzSchema.shape({
  "email": EzValidator().required().email().build(),
  "password": EzValidator()
      .required()
      .minLength(6)
      .matches(
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$',
          'Minimum six characters, at least one letter, one number and one special character')
      .build(),
  "age": EzValidator().required().min(18).build(),
}, identicalKeys: true);

// check validity

Map<String, String> errors = mySchema.validateSync({
  "email": 'iheb@pixelium.tn',
  "password": '444',
  "age": "17"
});

print(errors);

// output if the form not valid
//
// {
//    "password": 'The field must be at least 6 characters long',
//    "options": 'options must not be one of the following value: A,B',
//    "age": 'Test not valid please recheck'
//  }
//
// output if the form is valid
//{}

```

## Copyright

Validator code inspired from [form_validator](https://pub.dev/packages/form_validator)
