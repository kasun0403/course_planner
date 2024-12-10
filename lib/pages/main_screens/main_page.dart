import 'package:course_planner/constants/colors.dart';
import 'package:course_planner/models/course_model.dart';
import 'package:course_planner/services/database/course_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseService = CourseServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main "),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Course Planner",
                    style: TextStyle(color: primaryColor),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 15)),
                      onPressed: () {
                        GoRouter.of(context).push("/add-new-course");
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            "Add Course",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Your study planner helps you to keep track of your study progress and manage your time effectively.",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Courses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Your running subjects',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder<List<Course>>(
                stream: courseService.courses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 5),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empty.jpg',
                            width: 200,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'No courses available.Feel free to add a course!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ));
                  } else {
                    final courses = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];

                        return Card(
                          elevation: 0,
                          color: lightBlue,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                course.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                course.description,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                              ),
                              onTap: () {
                                GoRouter.of(context).push(
                                  '/single-course',
                                  extra: course,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
