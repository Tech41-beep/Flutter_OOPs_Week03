
class Course{
  final String id;
  final String name;
  final Set<String> _studentIds = {};

  Course({
    required this.id,
    required this.name,
  });

  Set<String> get studentIds => Set<String>.unmodifiable(_studentIds);

bool hasStudent(String studentId) {
    return _studentIds.contains(studentId);
  }

  void enrollStudent(String studentId) {
    _studentIds.add(studentId);
  }

  void removeStudent(String studentId) {
    _studentIds.remove(studentId);
  }
 
 
}