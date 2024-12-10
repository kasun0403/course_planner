import 'dart:io';

class Note {
  final String id;
  final String title;
  final String description;
  final String section;
  final String reference;
  final File? imageData;
  final String? imageUrl;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.section,
    required this.reference,
    this.imageData,
    this.imageUrl,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      section: json['section'] ?? "",
      reference: json['reference'] ?? "",
      imageData: json['imageData'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'section': section,
      'reference': reference,
      'imageData': imageData,
      'imageUrl': imageUrl,
    };
  }
}
