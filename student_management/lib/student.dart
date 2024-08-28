class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'country': country,
    };
  }
}

class Enrollment {
  final String program;
  final String year;
  final List<String> courses;

  Enrollment({
    required this.program,
    required this.year,
    required this.courses,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      program: json['program'],
      year: json['year'],
      courses: List<String>.from(json['courses']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'program': program,
      'year': year,
      'courses': courses,
    };
  }
}

class Student {
  final String studentId;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String email;
  final String phoneNumber;
  final Address address;
  final Enrollment enrollment;

  Student({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.enrollment,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: Address.fromJson(json['address']),
      enrollment: Enrollment.fromJson(json['enrollment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'email': email,
      'phone_number': phoneNumber,
      'address': address.toJson(),
      'enrollment': enrollment.toJson(),
    };
  }
}
