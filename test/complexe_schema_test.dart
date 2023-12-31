import 'package:ez_validator/ez_validator.dart';
import 'package:test/test.dart';

void main() {
  final EzSchema employeeSchema = EzSchema.shape({
    "name": EzValidator<String>().required(),
    "role": EzValidator<String>().required(),
  });

  final EzSchema departmentSchema = EzSchema.shape({
    "departmentName": EzValidator<String>().required(),
    "employees": EzValidator<List<Map<String, dynamic>>>()
        .required()
        .arrayOf<Map<String, dynamic>>(
          EzValidator().schema<Map<String, dynamic>>(employeeSchema),
        ),
  });
  final EzSchema complexSchema = EzSchema.shape({
    "departments": EzValidator<List<Map<String, dynamic>>>()
        .required()
        .arrayOf<Map<String, dynamic>>(
            EzValidator().schema<Map<String, dynamic>>(departmentSchema)),
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
            {"name": "John Doe", "role": "Developer"},
            {"name": "Jane Smith"},
          ],
        },
      ],
    };

    final errors = complexSchema.catchErrors(complexData);
    expect(errors, isNotEmpty, reason: 'Complex schema data should be invalid');
  });
}
