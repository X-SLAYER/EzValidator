## 0.0.1
- ez_validator

## 0.1.1
- add filledForm option + add set custom locale errors

## 0.1.2
- fix web plugin error + required custom messages

## 0.1.3
- add new validations methods

## 0.1.4
- Fix languages toggle

## 0.1.5
- Add support to all platforms

## 0.2.1
- Fix support for Desktop platforms
- Fix typos
- Remove unused files

## 0.2.2
- Add default values
- Add error key labels

## 0.3.0
- Nested Validation Support
- Extended Validation Methods:
  - String Validation Methods
  - Numerical Validation Methods
  - Date Validation Methods
  - Boolean Validation Method
  - General/Common Validation Methods
  - List (Array) Validation Methods
- **`catchErrors` Method**:
  - Introduced the `catchErrors` method for capturing and returning validation errors in a structured format. This method is particularly useful for detailed error analysis and customized error handling in applications.
- **`validateSync` Method**:
    - Added the `validateSync` method, offering synchronous validation that returns both processed data and validation errors. This method enhances usability by providing a convenient way to validate data and simultaneously retrieve the validated output.
  
## 0.3.1
- **`.when(String key, ValidationCallback<T> validator)`**: Provides conditional validation based on the value of another field in the schema. The method accepts a `key`, which refers to another field in the schema, and a `validator`, which is a function that executes the validation logic. The `validator` function should return `null` if the validation passes or a custom error message if it fails. This method is particularly useful for scenarios where the validation of one field depends on the value of another field, such as confirming a password.
- **`.transform(T Function(T) transformFunction)`**: Applies a transformation function to the field's value before any validation is performed. The method takes a `transformFunction` which receives the current field value and returns a transformed value. This method is useful for preprocessing the data, such as trimming strings, converting types, or formatting values, before applying the validation rules.

## 0.3.2
  - **`.arrayOf<EzValidator<T>>(EzValidator<T> itemValidator)`**: when you have a list of items that need to be individually validated. This method is ideal for scenarios like validating a list of user inputs, where each input must pass certain validation criteria.
  - **`.schema<EzSchema>(EzSchema schema)`**: is ideal for nested or complex data structures where multiple fields need to be validated in relation to each other. It's particularly useful in cases where you need to enforce a specific data format, such as validating JSON objects, complex forms, or data models.

## 0.3.3
- Improved Type Safety in `EzSchema` 