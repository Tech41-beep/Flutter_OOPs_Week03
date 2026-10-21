import '../model/course.model.dart';
import '../model/student.model.dart';
import '../model/course_result.model.dart';

class LmsSystem{
  final Map<String, Student> _students = {};
  final Map<String, Course> _courses = {};
  final Map<String, CourseResult> courseResults = {};

  void addStudent(Student student){
    if(_students.containsKey(student.id)){
      throw Exception('Student ${student.id} already exists');
    } else {
      _students[student.id] = student;
    }
  }

  void removeStudent(String studentId) {
     if(!_students.containsKey(studentId)) {
      throw Exception('Student $studentId does not exist');
    } 
  // 2. remove student every course
  for(final course in _courses.values) {
    if(course.hasStudent(studentId)) {
      course.removeStudent(studentId);
    }else {
      throw Exception('Student $studentId is not enrolled in course ${course.id}');
    }
  } 
  //  3.delete every result of the student
  courseResults.removeWhere((key, result) => result.studentId == studentId);
    // 4. remove the student
  _students.remove(studentId);
}


    
    void addCourse(Course course){
      if(_courses.containsKey(course.id)){
        throw Exception('Course ${course.id} already exists');
      } else {
        _courses[course.id] = course;
      }
    }

      void removeCourse(Course course ) {
        
      if(!_courses.containsKey(course.id)) {
        throw Exception('Course ${course.id} does not exist');
      } 
   
      // delete every result of the course
      courseResults.removeWhere((key, result)=> result.courseId == course.id);
        _courses.remove(course.id);
      //  
      _courses.remove(course.id);
    
      }

 void enrollStudent(String studentId, String courseId) {
  // 1. Check whether the student exists.
  if (!_students.containsKey(studentId)) {
    throw Exception('Student $studentId does not exist');
  }

  // 2. Find the course safely.
  final course = _courses[courseId];

  // 3. Check whether the course exists.
  if (course == null) {
    throw Exception('Course $courseId does not exist');
  }

  // 4. Prevent duplicate enrollment.
  if (course.hasStudent(studentId)) {
    throw Exception(
      'Student $studentId is already enrolled in course $courseId',
    );
  }
  
  // 5. Enroll the student.
  course.enrollStudent(studentId);
}

    bool isStudentEnrolled( String courseId,String studentId,){
      final course = _courses[courseId];
      if(course == null){
        throw Exception('Course $courseId does not exist');
    }
     return course.hasStudent(studentId);
  }

  void discardStudentFromCourse(String studentId, String courseId){
    // 1. Check whether the student exists.
    if(!_students.containsKey(studentId)){
      throw Exception('Student $studentId does not exist');
    }

    // 2. check whteher the course exists
    final course= _courses[courseId];
    if(course == null) {
      throw Exception('Course $courseId does not exist');
    }

    // 3.check whether the student is enrolled
    if(!course.hasStudent(studentId)){
      throw Exception('Student $studentId is not enrolled in course $courseId');
    }
    // 4. Remove the student from the course
    course.removeStudent(studentId);
 
  }
  String addResult(String studentId, String courseId , double score){
    // check whether the student is exists
    if(!_students.containsKey(studentId)){
      throw Exception('Student $studentId does not exist');
    }
    //  check whether the course is exists
    final course= _courses[courseId];
    if(course == null){
      throw Exception('Course $courseId does not exist');
    }
    // check enrollment 
    if(!course.hasStudent(studentId)){
      throw Exception('Student $studentId is not enrolled in course $courseId');
    }

    //  validate score

    if( score <0 || score >100){
      throw Exception('Score must be between 0 and 100');
    }

    // prevent duplicate result
    final existingResult = courseResults.values.any(
      (result)=> result.studentId == studentId &&
       result.courseId == courseId
    );
    if(existingResult){
      throw Exception('Result for student $studentId in course $courseId already exists');
    }

    //  create and store the result
    final resultId = '${studentId}_$courseId';
    final result = CourseResult(
      id : resultId,
      studentId : studentId,
      courseId : courseId,
      score : score,
    );

    // return the result id 
    return resultId;
  }
  }
