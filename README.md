# ez_validator

Dead simple field/object schema validation for flutter </br>
EzValidator api is inspired by [Yup](https://github.com/jquense/yup)

## EzValidator

EzValidator is a flutter schema builder for value validation. Define a schema, validate the shape of an existing value, or both.
EzValidator allow single or object validations

## Usage

You define your schema object.

```dart
EzSchema mySchema = EzSchema.shape({
  "email": EzValidator().email().required().build(),
  "password": EzValidator().required().minLength(6).build(),
  "options": EzValidator().notOneOf(['A', 'B']).build(),
  "age": EzValidator()
      .required()
      .defaultTest(
          'Test not valid please recheck', (v) => int.parse(v as String) > 18)
      .build()
});

// check validity

Map<String, String> errors = mySchema.validateSync({
  "email": 'iheb@pixelium.tn',
  "password": '444',
  "options": 'A',
  "age": "10"
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

