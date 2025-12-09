## 0.3.7

- Add `Ez` alis for `EzValidator`
- 
## 0.3.6

- Add `union`: Used for composing "OR" types by combining multiple validators into a union.

## 0.3.5

- Add `noUnknown`: Validate that the data values only contain keys specified in the schema.

## 0.3.4

- Remove unused key in the `.when` method.
- Add `.dependsOn`: enables conditional validation based on the state of other fields within the same schema.

## 0.3.3

- Improved Type Safety in `EzSchema`.

## 0.3.2

- **`.arrayOf<EzValidator<T>>(EzValidator<T> itemValidator)`**: Validates a list of items individually, ideal for scenarios like validating multiple user inputs.
- **`.schema<EzSchema>(EzSchema schema)`**: Validates complex or nested data structures, useful for enforcing specific data formats like JSON objects, forms, or data models.

## 0.3.1

- **`.when(String key, ValidationCallback<T> validator)`**: Allows conditional validation based on another field's value.
- **`.transform(T Function(T) transformFunction)`**: Applies a transformation to the field's value before validation, useful for data preprocessing (e.g., trimming or formatting).

## 0.3.0

- Nested Validation Support.
- Extended Validation Methods:
  - String, Numerical, Date, Boolean, General/Common, and List Validation Methods.
- **`catchErrors` Method**: Captures validation errors in a structured format for customized error handling.
- **`validateSync` Method**: Provides synchronous validation that returns both processed data and errors.

## 0.2.2

- Add default values.
- Add error key labels.

## 0.2.1

- Fix support for Desktop platforms.
- Fix typos.
- Remove unused files.

## 0.1.5

- Add support to all platforms.

## 0.1.4

- Fix language toggle.

## 0.1.3

- Add new validation methods.

## 0.1.2

- Fix web plugin error.
- Add required custom messages.

## 0.1.1

- Add `filledForm` option.
- Add support for setting custom locale errors.

## 0.0.1

- Initial release of `ez_validator`.
