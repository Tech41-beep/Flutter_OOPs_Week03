
import 'package:test/test.dart';
import '../model/course.model.dart';
import '../model/student.model.dart';
import '../service/lms.service.dart';
void main() {
  test('adds and enrolls a student in a course', () {
    final lms = LmsSystem()
      ..addStudent(Student(id: 's1', name: 'Sam'))
      ..addCourse(Course(id: 'c1', name: 'Math'))
      ..enrollStudent('s1', 'c1');

    expect(lms.isStudentEnrolled('c1', 's1'), isTrue);
  });

  test('rejects duplicate enrollment', () {
    final lms = LmsSystem()
      ..addStudent(Student(id: 's1', name: 'Sam'))
      ..addCourse(Course(id: 'c1', name: 'Math'))
      ..enrollStudent('s1', 'c1');

    expect(() => lms.enrollStudent('s1', 'c1'), throwsException);
  });

  test('discards a student from a course', () {
    final lms = LmsSystem()
      ..addStudent(Student(id: 's1', name: 'Sam'))
      ..addCourse(Course(id: 'c1', name: 'Math'))
      ..enrollStudent('s1', 'c1');

    lms.discardStudentFromCourse('s1', 'c1');

    expect(lms.isStudentEnrolled('c1', 's1'), isFalse);
  });
}
