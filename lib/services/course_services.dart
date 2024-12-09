import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_planner/models/course_model.dart';

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
      print("Error adding course");
    }
  }
}
