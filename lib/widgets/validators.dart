import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = RequiredValidator(errorText: '* This field is required');
final phoneValidator = MultiValidator([
  // RequiredValidator(errorText: '* This field is required'),
  MinLengthValidator(10, errorText: 'Format: 0712345678'),
  MaxLengthValidator(10, errorText: 'Enter a valid Mobile number'),
]);
final emailValidator = PatternValidator(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    errorText: 'Incorrent email address');

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: '* This field is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ],
);

final incorrectValidator = RequiredValidator(errorText: '*Incorrect entry');
