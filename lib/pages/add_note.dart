import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_planner/models/course_model.dart';
import 'package:course_planner/models/note_model.dart';
import 'package:course_planner/services/database/note_service.dart';
import 'package:course_planner/utils/util_functions.dart';
import 'package:course_planner/widgets/custom_button.dart';
import 'package:course_planner/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddNotePage extends StatefulWidget {
  final Course course;
  const AddNotePage({
    super.key,
    required this.course,
  });

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage; // Holds the selected image
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _referencesController = TextEditingController();

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  // Method to submit the form
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final Note note = Note(
          id: "",
          title: _titleController.text,
          description: _descriptionController.text,
          section: _sectionController.text,
          reference: _referencesController.text,
          imageData: _selectedImage != null ? File(_selectedImage!.path) : null,
        );

        await NoteService().createNote(widget.course.id, note);
        showSnackBar(context: context, text: "Note added succusfully");

        await Future.delayed(const Duration(seconds: 2));
        GoRouter.of(context).go('/');
      } catch (e) {
        print("$e");
        showSnackBar(context: context, text: "Failed to add note");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _sectionController.dispose();
    _referencesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Note For Your Course',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),

              //description
              const Text(
                'Fill in the details below to add a new note. And start managing your study planner.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInputField(
                        controller: _titleController,
                        labelText: 'Note Title',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter the Note Title';
                          }
                          return null;
                        },
                      ),
                      CustomInputField(
                        controller: _descriptionController,
                        labelText: 'Description',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter the Description';
                          }
                          return null;
                        },
                      ),
                      CustomInputField(
                        controller: _sectionController,
                        labelText: 'Section Name',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter the Section name';
                          }
                          return null;
                        },
                      ),
                      CustomInputField(
                        controller: _referencesController,
                        labelText: 'Reference Books',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter the Reference Books';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),

              const Divider(),
              const Text(
                'Upload Note Image , for better understanding and quick revision',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              // Button to upload image
              CustomButton(
                onPressed: _pickImage,
                text: 'Upload Note Image',
              ),
              const SizedBox(height: 20),
              // Display selected image
              _selectedImage != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Image:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(_selectedImage!.path),
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'No image selected.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
              const SizedBox(height: 20),
              // Submit button
              CustomButton(
                onPressed: () => _submitForm(context),
                text: 'Submit Note',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
