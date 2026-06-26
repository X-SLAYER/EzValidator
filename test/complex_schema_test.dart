import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  final EzSchema employeeSchema = EzSchema.shape({
    "name": Ez<String>().required(),
    "role": Ez<String>().required(),
  });

  final EzSchema departmentSchema = EzSchema.shape({
    "departmentName": Ez<String>().required(),
    "employees": Ez<List<Map<String, dynamic>>>()
        .required()
        .arrayOf<Map<String, dynamic>>(
          Ez().schema<Map<String, dynamic>>(employeeSchema),
        ),
  });
  final EzSchema complexSchema = EzSchema.shape({
    "departments": Ez<List<Map<String, dynamic>>>()
        .required()
        .arrayOf<Map<String, dynamic>>(
            Ez().schema<Map<String, dynamic>>(departmentSchema)),
  });

  final addContactSchema = EzSchema.shape({
    'email': Ez<String>().required().email(),
    'additional_emails': Ez(optional: true, defaultValue: []).schema(
      EzSchema.shape({
        'email': Ez<String>().required().email(),
        'is_primary': Ez<bool>(optional: true, defaultValue: false),
        'label': Ez<dynamic>(optional: true),
      }),
    ),
  });
  test('Valid employee data passes validation', () {
    final employeeData = {
      "name": "John Doe",
      "role": "Developer",
    };
    final errors = employeeSchema.catchErrors(employeeData);
    expect(errors, isEmpty, reason: 'Employee data should be valid');
  });

  test('Invalid employee data fails validation', () {
    final employeeData = {
      "name": "John Doe",
    };

    final errors = employeeSchema.catchErrors(employeeData);
    expect(errors, isNotEmpty, reason: 'Employee data should be invalid');
  });

  test('Valid department data passes validation', () {
    final departmentData = {
      "departmentName": "Engineering",
      "employees": [
        {"name": "John Doe", "role": "Developer"},
        {"name": "Jane Smith", "role": "Manager"},
      ],
    };

    final (_, errors) = departmentSchema.validateSync(departmentData);
    expect(errors, isEmpty, reason: 'Department data should be valid');
  });

  test('Invalid department data fails validation', () {
    final departmentData = {
      "departmentName": "Engineering",
      "employees": [
        {"name": "John Doe", "role": "Developer"},
        {"name": "Jane Smith"},
      ],
    };

    final errors = departmentSchema.catchErrors(departmentData);
    expect(errors, isNotEmpty, reason: 'Department data should be invalid');
  });

  test('Valid complex schema data passes validation', () {
    final complexData = {
      "departments": [
        {
          "departmentName": "Engineering",
          "employees": [
            {"name": "John Doe", "role": "Developer"},
            {"name": "Jane Smith", "role": "Manager"},
          ],
        },
      ],
    };

    final errors = complexSchema.catchErrors(complexData);
    expect(errors, isEmpty, reason: 'Complex schema data should be valid');
  });

  test('Invalid complex schema data fails validation', () {
    final complexData = {
      "departments": [
        {
          "departmentName": "Engineering",
          "employees": [
            {"name": "John Doe"},
            {"name": "Jane Smith"},
          ],
        },
      ],
    };

    final errors = complexSchema.catchErrors(complexData);
    expect(errors, isNotEmpty, reason: 'Complex schema data should be invalid');
  });

  test('Valid contact schema data passes validation', () {
    final contactSchema = {
      "email": "bV1kM@example.com",
      "additional_emails": [],
    };
    final errors = addContactSchema.catchErrors(contactSchema);
    expect(errors, isEmpty, reason: 'Contact schema data should be valid');
  });

  test('Valid contact schema data should fail validation', () {
    final contactSchema = {
      "email": "bV1kM@example.com",
      "additional_emails": [
        {
          "is_primary": true,
          "email": "bV1kM@example.com",
        },
        {
          "is_primary": true,
        },
      ],
    };
    final errors = addContactSchema.catchErrors(contactSchema);
    expect(errors, isNotEmpty, reason: 'addional_emails email is required');
  });
}
