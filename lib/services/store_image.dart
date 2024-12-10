import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImage({required noteImage, required courseId}) async {
    try {
      Reference ref = storage
          .ref()
          .child("note-images")
          .child("$courseId/${DateTime.now()}");

      UploadTask task = ref.putFile(
        noteImage,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      TaskSnapshot snapshot = await task;
      String doiwnloadUrl = await snapshot.ref.getDownloadURL();
      return doiwnloadUrl;
    } catch (e) {
      print("$e");
      return "";
    }
  }
}
