import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_planner/models/assignment_model.dart';

class AssignmentService {
  final CollectionReference couseCollectionReference =
      FirebaseFirestore.instance.collection("courses");

  //create new assignment
  Future<void> createNewAssignment(
      String courseid, Assignment assignment) async {
    try {
      // assignment collection reference

      final CollectionReference assignmentCollectionRef =
          couseCollectionReference.doc(courseid).collection("assignments");

      final Map<String, dynamic> data = assignment.toJson();

      DocumentReference docRef = await assignmentCollectionRef.add(data);
      await docRef.update({"id": docRef.id});
    } catch (e) {
      print("Error creating assignment");
    }
  }
}
