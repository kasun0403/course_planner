import 'package:course_planner/models/course_model.dart';
import 'package:course_planner/services/course_services.dart';
import 'package:course_planner/utils/util_functions.dart';
import 'package:course_planner/widgets/custom_button.dart';
import 'package:course_planner/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNewCourse extends StatelessWidget {
  AddNewCourse({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _courseSheduleController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // Save form
      _formKey.currentState?.save();

      // Add course to Firestore
      try {
        // Create a new course
        final Course course = Course(
          id: '',
          name: _courseNameController.text,
          description: _courseDescriptionController.text,
          duration: _courseDurationController.text,
          schedule: _courseSheduleController.text,
          instructor: _courseInstructorController.text,
        );

        await CourseServices().addNewCourse(course);

        // Show success SnackBar
        if (context.mounted) {
          showSnackBar(context: context, text: 'Course added successfully!');
        }

        // Delay navigation to ensure SnackBar is displayed
        await Future.delayed(const Duration(seconds: 2));

        // Navigate to the home page
        GoRouter.of(context).go('/');
      } catch (error) {
        print(error);
        if (context.mounted) {
          showSnackBar(context: context, text: 'Failed to add course!');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Course"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Fill in the details below to add a new course.And start managing your study planner.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),
                CustomInputField(
                  controller: _courseNameController,
                  labelText: "Course Name",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a course name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: _courseDescriptionController,
                  labelText: "Course Description",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a course description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: _courseDurationController,
                  labelText: "Course Duration",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: _courseSheduleController,
                  labelText: "Course Shedule",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course schedule';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: _courseInstructorController,
                  labelText: "Course Instructor",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course instructor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Add Course',
                  onPressed: () => _submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
