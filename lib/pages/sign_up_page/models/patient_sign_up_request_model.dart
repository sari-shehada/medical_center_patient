import '../../../core/extensions/date_time_extensions.dart';

class PatientSignUpForm {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final bool isMale;
  final DateTime dateOfBirth;

  PatientSignUpForm({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.isMale,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'isMale': isMale,
      'dateOfBirth': dateOfBirth.getDateOnly(),
    };
  }
}
