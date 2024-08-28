import 'dart:convert';
import 'dart:io';
import 'student.dart';

class StudentManager {
  final String filename;

  StudentManager(this.filename);

  Future<Map<String, dynamic>> _readData() async {
    try {
      final file = File(filename);
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      return {"students": []};
    }
  }

  Future<void> _writeData(Map<String, dynamic> data) async {
    final file = File(filename);
    await file.writeAsString(jsonEncode(data), flush: true);
  }

  Future<void> addStudent(Student student) async {
    final data = await _readData();
    data["students"].add(student.toJson());
    await _writeData(data);
  }

  Future<void> updateStudent(String studentId, Student updatedStudent) async {
    final data = await _readData();
    final students = data["students"] as List;
    for (int i = 0; i < students.length; i++) {
      if (students[i]["student_id"] == studentId) {
        students[i] = updatedStudent.toJson();
        await _writeData(data);
        return;
      }
    }
    print('Student with ID $studentId not found.');
  }

  Future<List<Student>> getStudents() async {
    final data = await _readData();
    return (data['students'] as List)
        .map((json) => Student.fromJson(json))
        .toList();
  }

  Future<Student?> findStudentById(String studentId) async {
    final data = await _readData();
    final students = data["students"] as List;
    for (var student in students) {
      if (student["student_id"] == studentId) {
        return Student.fromJson(student);
      }
    }
    return null;
  }

  Future<List<Student>> findStudentsByName(String name) async {
    final data = await _readData();
    final students = data["students"] as List;
    return students
        .where((student) =>
            student["first_name"].toLowerCase().contains(name.toLowerCase()) ||
            student["last_name"].toLowerCase().contains(name.toLowerCase()))
        .map((json) => Student.fromJson(json))
        .toList();
  }
}