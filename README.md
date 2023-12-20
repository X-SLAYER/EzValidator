<p align="center">
  <a href="#"><img src="https://raw.githubusercontent.com/X-SLAYER/EzValidator/master/ez_validator_logo.png" height=250 /></a>
</p>

# Ez Validator

EzValidator offers a dead-simple approach to field and object schema validation tailored for Flutter. Inspired by the intuitive API of [Yup](https://github.com/jquense/yup), EzValidator simplifies the process of defining and enforcing data schemas within your Flutter applications.

## Key Features of EzValidator

- **Flutter Schema Builder**: Seamlessly integrate EzValidator into your Flutter projects to build and manage data validation schemas.
- **Versatile Validation**: Whether you need to validate individual fields or entire objects, EzValidator is designed to handle both with ease.

## Installing

Add EzValidator to your pubspec:

```yaml
dependencies:
  ez_validator: any # or the latest version on Pub
```

## Getting Started

To begin with `EzValidator`, define a schema object that represents the structure and validation rules for your data. Below is an example demonstrating how to create a schema for user data, including validations for email, password, and date fields.

### Defining a Schema

Create a schema using `EzSchema.shape` where each field in the data object is associated with an `EzValidator` specifying its validation rules:

```dart
final EzSchema userSchema = EzSchema.shape(
  {
    "email": EzValidator<String>(label: "Email").required().email(),
    "password": EzValidator<String>(label: 'Password').required().minLength(8),
    'date': EzValidator<DateTime>()
        .required()
        .date()
        .minDate(DateTime(2019))
        .maxDate(DateTime(2025)),
  },
);
``` 

 
### Validating Data

Use the `catchErrors` method of the schema to validate a data object. This method returns a map of validation errors, if any:

```dart
final errors = userSchema.catchErrors({
  'email': 'example@domain.com',
  'password': '12345678',
  'date': DateTime.now(),
});

print(errors);

``` 

### Understanding the Output

- If there are validation errors, `errors` will contain a map of field names to error messages. For example:
    
```dart
{
  "password": "Minimum six characters, at least one letter, one number and one special character",
  "age": "The field must be greater than or equal to 18"
}

``` 
    
- If the data object is valid according to the schema, `errors` will be an empty map (`{}`).

--------


Additionally, use the `validateSync` method to validate data and simultaneously retrieve the processed data along with any errors:


```dart
final (data, errors) = userSchema.validateSync({
  'email': 'example@domain.com',
  'password': '12345678',
  'date': DateTime.now(),
});

print(data);   // Processed data
print(errors); // Validation errors

```
### Understanding the Output

- If there are validation errors, the `errors` map will contain field names and their corresponding error messages.
- If the data object passes all validations, `errors` will be an empty map (`{}`).
- The `data` map returned by `validateSync` contains the processed data, which may include default values set by the schema.

 
## Custom Validation with `addMethod`

`EzValidator` also supports custom validation rules through the `addMethod` function. This feature allows you to define your own validation logic, making `EzValidator` highly adaptable to various unique use cases.

### Using `addMethod` for Custom Validation

You can use `addMethod` to add custom validation functions to your validator. Each function should take the value to be validated as an argument and return `null` if the value passes the validation or an error message if it fails.

Here's an example of using `addMethod` to validate a JSON structure:

```dart
final checkJson = EzValidator<Map<String, dynamic>>()
    .addMethod((v) => v?['foo'] == 'bar' ? null : 'Foo should be bar')
    .addMethod((v) => v?['bar'] == 'Flutter' ? null : 'Bar should be Flutter')
    .addMethod((v) => v?['items'][0] == 'a' ? null : 'First item should be a')
    .build();

final errors = checkJson({
  'foo': 'bar',
  'bar': 'Flutter',
  'items': ['a', 'b', 'c']
});

print(errors); // Outputs the validation errors, if any

```
If any of these checks fail, the corresponding error message is returned.

### Flexibility of Custom Validation
 
The `addMethod` function opens up endless possibilities for custom validation logic, allowing `EzValidator` to be tailored to your specific validation needs.

 
# Direct Use in Flutter Widgets

`EzValidator` is designed to integrate smoothly with Flutter widgets, providing a straightforward way to add validation to user inputs. One common use case is within forms, where you can directly use `EzValidator` in form fields such as `TextFormField`.

### Example: Email Validation in a TextFormField

Here's an example of how to apply `EzValidator` for email validation in a `TextFormField`:

```dart
TextFormField(
  validator: EzValidator<String>()
      .required()
      .email()
      .build(),
  decoration: InputDecoration(labelText: 'Email'),
),

```
If the input fails these validations, the corresponding error message is displayed under the `TextFormField`.

# Validation Methods

`EzValidator` offers a wide range of validation methods to suit different data types and validation scenarios. Below is a breakdown of these methods:

- ### General/Common Validations

  - **`.required([String? message])`**: Ensures that the value is not null or empty. This is a fundamental validation to check for the presence of a value.
  - **`.isType(Type type, [String? message])`**: Validates that the value matches the specified `type`. This method is useful for type checking in more dynamic contexts.
  - **`.minLength(int minLength, [String? message])`**: Checks that the length of the value (String, List, or Map) is not less than the specified `minLength`.
  - **`.maxLength(int maxLength, [String? message])`**: Ensures that the length of the value (String, List, or Map) does not exceed the specified `maxLength`.
  - **`.addMethod(bool Function(T? v) validWhen, [String? message])`**: Allows for the addition of custom validation logic. If the provided function `validWhen` returns `false`, the custom error message is returned.
  - **`.when(String key, ValidationCallback<T> validator)`**: Provides conditional validation based on the value of another field in the schema. The method accepts a `key`, which refers to another field in the schema, and a `validator`, which is a function that executes the validation logic. The `validator` function should return `null` if the validation passes or a custom error message if it fails. This method is particularly useful for scenarios where the validation of one field depends on the value of another field, such as confirming a password.

- ### String Validations
  
  - **`.email([String? message])`**: Validates if the value is a valid email address.
  - **`.phone([String? message])`**: Validates if the value is a valid phone number.
  - **`.ip([String? message])`**: Validates if the value is a correct IPv4 address.
  - **`.ipv6([String? message])`**: Validates if the value is a correct IPv6 address.
  - **`.url([String? message])`**: Validates if the value is a valid URL address.
  - **`.uuid([String? message])`**: Validates if the value is a valid UUID.
  - **`.lowerCase([String? message])`**: Checks if the value is in lowercase.
  - **`.upperCase([String? message])`**: Checks if the value is in uppercase.
  - **`.matches(RegExp reg, [String? message])`**: Validates if the value matches the provided regular expression pattern.
  
- ### Numerical Validations
  
  - **`.min(num min, [String? message])`**: Validates if the numeric value is greater than or equal to `min`.
  - **`.max(num max, [String? message])`**: Validates if the numeric value is less than or equal to `max`.
  - **`.positive([String? message])`**: Validates if the numeric value is positive.
  - **`.negative([String? message])`**: Validates if the numeric value is negative.
  - **`.number([String? message])`**: Checks if the value is a number.
  - **`.isInt([String? message])`**: Checks if the value is an integer.
  - **`.isDouble([String? message])`**: Checks if the value is a double. Also validates integers, as they can be implicitly converted to doubles.
  - **`.notNumber([String? message])`**: Checks if the value is not a number.

- ### Date Validations

  - **`.date([String? message])`**: Checks if the value is a valid date. If the value is a `DateTime` object or can be parsed into a `DateTime`, the validation passes.
  - **`.minDate(DateTime date, [String? message])`**: Ensures the date value is not earlier than the specified minimum date. If the value is a `DateTime` object and is equal to or after the provided `date`, the validation passes.
  - **`.maxDate(DateTime date, [String? message])`**: Ensures the date value is not later than the specified maximum date. If the value is a `DateTime` object and is equal to or before the provided `date`, the validation passes.

- ### Boolean Validation

  - **`.boolean([String? message])`**: Validates whether the value is a boolean (`true` or `false`). This method checks the data type of the value and ensures it is strictly a boolean.

- ### List (Array) Validations
  
  - **`.listOf(Type type, [String? message])`**: Validates that each element in the list is of the specified `type`. It iterates through the list and checks if each item matches the given type.
      
  - **`.oneOf(List<T> items, [String? message])`**: Checks if the value is one of the specified items in the list. It is useful for ensuring a value is among a predefined set of options.
      
  - **`.notOneOf(List<T> items, [String? message])`**: Ensures that the value is not one of the specified items in the list. This is the opposite of `.oneOf` and is used to exclude certain values.



## Using Custom Locales with `EzValidator`

`EzValidator` allows the integration of custom locales, facilitating localization of error messages. Below is an example of creating an Arabic locale (`ArLocale`) and applying it in `EzValidator`.

#### Creating `ArLocale`

**Define the Custom Locale**: Implement the `EzLocale` interface to create `ArLocale` with Arabic error messages.

```dart
class ArLocale implements EzLocale {
  const ArLocale();

  // Implement all required methods with Arabic error messages
  @override
  String minLength(String v, int n, [String? label]) =>
      '${label ?? 'الحقل'} يجب أن يحتوي على الأقل $n أحرف';
  // ... other method implementations ...

  @override
  String required([String? label]) => '${label ?? 'الحقل'} مطلوب';

  // Example implementation for a valid email
  @override
  String email(String v, [String? label]) =>
      '${label ?? 'الحقل'} ليس بريدًا إلكترونيًا صحيحًا';
  
  // ... further implementations for other methods ...
}
```
**Set the Locale in `EzValidator`**: Configure `EzValidator` to use the `ArLocale`.

```dart
EzValidator.setLocale(const ArLocale());
```

**Use Validators as Usual**: Now, the validation error messages will be in Arabic.

## Nested Validation Example with `EzValidator`

`EzValidator` not only handles simple validations but also excels in managing complex, nested data structures. This is particularly useful when dealing with intricate data models, like user profiles with multiple layers of details. Here’s an example of how you can define a nested validation schema using `EzValidator`:

#### Defining a Complex User Profile Schema

```dart
final EzSchema userProfileSchema = EzSchema.shape({
  "firstName": EzValidator<String>().required(),
  "lastName": EzValidator<String>().required(),
  "email": EzValidator<String>().required().email(),
  "age": EzValidator<int>().min(18).max(100),
  'contactDetails': EzSchema.shape({
    'mobile': EzValidator<String>()
        .required()
        .matches(RegExp(r'^\+\d{10,15}$'), 'Invalid phone number'),
    'landline': EzValidator<String?>(optional: true),
  }),
  'address': EzSchema.shape({
    'street': EzValidator<String>().required(),
    'city': EzValidator<String>().required(),
    'state': EzValidator<String>().required(),
    'zipCode': EzValidator<num>().required(),
    'country': EzSchema.shape({
      'name': EzValidator<String>(defaultValue: 'TUNISIA').required(),
      'code': EzValidator<String>().required(),
      'continent': EzSchema.shape({
        'name': EzValidator<String>().required(),
        'code': EzValidator<String>().required(),
      })
    }),
  }),
  'employment': EzSchema.shape({
    'current': EzValidator<String?>(optional: true),
    'previous': EzSchema.shape({
      'companyName': EzValidator<String>().required(),
      'position': EzValidator<String>().required(),
      'years': EzValidator<int>().min(1).max(50),
    }),
  }),
});

```

Validation

```dart
  final (data, errors) = userProfileSchema.validateSync({
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john.doe@example.com',
      'age': 30,
      'contactDetails': {
        'mobile': '+12345678901',
      },
      'address': {
        'street': '123 Main St',
        'city': 'Anytown',
        'state': 'Anystate',
        'zipCode': 12345,
        'country': { }, // I will not define the country
      },
      'employment': {
        'current': 'Current Company',
        'previous': {
          'companyName': 'Previous Company',
          'position': 'Previous Position',
          'years': 5,
        },
      },
    });

  print(data); 

// Result of displayed data will contain country with default values
// {
//   firstName: John,
//   lastName: Doe,
//   email: john.doe@example.com,
//   age: 30,
//   contactDetails: { mobile: +12345678901, landline: null },
//   address:
//     {
//       street: 123 Main St,
//       city: Anytown,
//       state: Anystate,
//       zipCode: 12345,
//       country:
//         { name: TUNISIA, code: null, continent: { name: null, code: null } },
//     },
//   employment:
//     {
//       current: Current Company,
//       previous:
//         {
//           companyName: Previous Company,
//           position: Previous Position,
//           years: 5,
//         },
//     },
// }
// 

print(errors)

// {address: {country: {code: The field is required, continent: {name: The field is required, code: The field is required}}}}


```

## ShowCase

| with default locale                                                                                                                    | with French locale                                                                                                                     |
| -------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://user-images.githubusercontent.com/22800380/134804272-16909d85-fee5-4a51-8cec-08b69533c01a.gif?raw=true" width="250"> | <img src="https://user-images.githubusercontent.com/22800380/134804269-cc1d48ff-a1e0-401a-a7cd-2d5cd8b3b869.gif?raw=true" width="250"> |