import 'dart:io';
import 'student.dart';
import 'student_management.dart';

Future<void> main() async {
  final manager = StudentManager('data/students.json');

  while (true) {
    print('\nMenu:');
    print('1. Add Student');
    print('2. Update Student');
    print('3. Find Student by ID');
    print('4. Find Students by Name');
    print('5. Exit');
    stdout.write('Choose an option: ');
    final option = stdin.readLineSync();

    switch (option) {
      case '1':
        await addStudent(manager);
        break;
      case '2':
        await updateStudent(manager);
        break;
      case '3':
        await findStudentById(manager);
        break;
      case '4':
        await findStudentsByName(manager);
        break;
      case '5':
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}

Future<void> addStudent(StudentManager manager) async {
  print('Enter student details:');

  stdout.write('Student ID: ');
  final studentId = stdin.readLineSync()!;

  stdout.write('First Name: ');
  final firstName = stdin.readLineSync()!;

  stdout.write('Last Name: ');
  final lastName = stdin.readLineSync()!;

  stdout.write('Date of Birth (YYYY-MM-DD): ');
  final dateOfBirth = stdin.readLineSync()!;

  stdout.write('Gender: ');
  final gender = stdin.readLineSync()!;

  stdout.write('Email: ');
  final email = stdin.readLineSync()!;

  stdout.write('Phone Number: ');
  final phoneNumber = stdin.readLineSync()!;

  stdout.write('Address Street: ');
  final addressStreet = stdin.readLineSync()!;

  stdout.write('Address City: ');
  final addressCity = stdin.readLineSync()!;

  stdout.write('Address State: ');
  final addressState = stdin.readLineSync()!;

  stdout.write('Address Zip Code: ');
  final addressZipCode = stdin.readLineSync()!;

  stdout.write('Address Country: ');
  final addressCountry = stdin.readLineSync()!;

  stdout.write('Program: ');
  final program = stdin.readLineSync()!;

  stdout.write('Year: ');
  final year = stdin.readLineSync()!;

  stdout.write('Courses (comma separated): ');
  final courses = stdin.readLineSync()!.split(',');

  final student = Student(
    studentId: studentId,
    firstName: firstName,
    lastName: lastName,
    dateOfBirth: dateOfBirth,
    gender: gender,
    email: email,
    phoneNumber: phoneNumber,
    address: Address(
      street: addressStreet,
      city: addressCity,
      state: addressState,
      zipCode: addressZipCode,
      country: addressCountry,
    ),
    enrollment: Enrollment(
      program: program,
      year: year,
      courses: courses,
    ),
  );

  await manager.addStudent(student);
  print('Student added successfully.');
}

Future<void> updateStudent(StudentManager manager) async {
  stdout.write('Enter Student ID to update: ');
  final studentId = stdin.readLineSync()!;

  final student = await manager.findStudentById(studentId);
  if (student == null) {
    print('Student with ID $studentId not found.');
    return;
  }

  print('Enter new details (leave blank to keep current value):');

  stdout.write('First Name [${student.firstName}]: ');
  final firstName = stdin.readLineSync();
  stdout.write('Last Name [${student.lastName}]: ');
  final lastName = stdin.readLineSync();
  stdout.write('Date of Birth [${student.dateOfBirth}]: ');
  final dateOfBirth = stdin.readLineSync();
  stdout.write('Gender [${student.gender}]: ');
  final gender = stdin.readLineSync();
  stdout.write('Email [${student.email}]: ');
  final email = stdin.readLineSync();
  stdout.write('Phone Number [${student.phoneNumber}]: ');
  final phoneNumber = stdin.readLineSync();

  final updatedStudent = Student(
    studentId: student.studentId,
    firstName: firstName!.isEmpty ? student.firstName : firstName,
    lastName: lastName!.isEmpty ? student.lastName : lastName,
    dateOfBirth: dateOfBirth!.isEmpty ? student.dateOfBirth : dateOfBirth,
    gender: gender!.isEmpty ? student.gender : gender,
    email: email!.isEmpty ? student.email : email,
    phoneNumber: phoneNumber!.isEmpty ? student.phoneNumber : phoneNumber,
    address: student.address, // assuming address remains the same for simplicity
    enrollment: student.enrollment, // assuming enrollment remains the same for simplicity
  );

  await manager.updateStudent(studentId, updatedStudent);
  print('Student updated successfully.');
}

Future<void> findStudentById(StudentManager manager) async {
  stdout.write('Enter Student ID: ');
  final studentId = stdin.readLineSync()!;

  final student = await manager.findStudentById(studentId);
  if (student == null) {
    print('Student with ID $studentId not found.');
  } else {
    print('Student found: ${student.firstName} ${student.lastName}');
  }
}

Future<void> findStudentsByName(StudentManager manager) async {
  stdout.write('Enter name to search: ');
  final name = stdin.readLineSync()!;

  final students = await manager.findStudentsByName(name);
  if (students.isEmpty) {
    print('No students found with name containing "$name".');
  } else {
    print('Students found:');
    for (var student in students) {
      print('${student.studentId}: ${student.firstName} ${student.lastName}');
    }
  }
}
