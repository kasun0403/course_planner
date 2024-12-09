import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_planner/models/course_model.dart';
import 'package:intl/date_symbols.dart';

class CourseServices {
  final CollectionReference couseCollectionReference =
      FirebaseFirestore.instance.collection("courses");
  //

  //add new course
  Future<void> addNewCourse(Course course) async {
    try {
      final Map<String, dynamic> data = course.toJson();
      final docReference = await couseCollectionReference.add(data);

      await docReference.update({'id': docReference.id});
    } catch (e) {
      print("Error adding course $e");
    }
  }

  //get courses
  Stream<List<Course>> get courses {
    try {
      return couseCollectionReference.snapshots().map((snapshot) {
        return snapshot.docs.map((document) {
          return Course.fromJson(document.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      print("Error getting course $en_USPatterns");
      return Stream.empty();
    }
  }
}
