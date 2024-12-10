import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_planner/models/note_model.dart';
import 'package:course_planner/services/store_image.dart';

class NoteService {
  final CollectionReference courseCollectionRef =
      FirebaseFirestore.instance.collection("courses");

  Future<void> createNote(String courseId, Note noteData) async {
    try {
      final CollectionReference noteCollectionRef =
          courseCollectionRef.doc(courseId).collection("note");
      String? imageUrl;
      if (noteData.imageData != null) {
        imageUrl = await StorageService()
            .uploadImage(noteImage: noteData.imageData, courseId: courseId);
      }
      final note = Note(
        id: "",
        title: noteData.title,
        description: noteData.description,
        section: noteData.section,
        reference: noteData.reference,
        imageUrl: imageUrl,
      );
      final DocumentReference docRef =
          await noteCollectionRef.add(note.toJson());
      await docRef.update({"id": docRef.id});
    } catch (e) {
      print("$e");
    }
  }
}
