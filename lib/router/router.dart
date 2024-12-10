import 'package:course_planner/models/course_model.dart';
import 'package:course_planner/pages/add_assignments.dart';
import 'package:course_planner/pages/add_new_course.dart';
import 'package:course_planner/pages/add_note.dart';
import 'package:course_planner/pages/home_page.dart';
import 'package:course_planner/pages/single_course_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return const MaterialPage(
          child: Scaffold(
        body: Center(
          child: Text("This page is not available"),
        ),
      ));
    },
    routes: [
      //homepage
      GoRoute(
        path: "/",
        name: "home",
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: "/add-new-course",
        name: "add new course",
        builder: (context, state) {
          return AddNewCourse();
        },
      ),
      GoRoute(
        path: "/single-course",
        name: "single course",
        builder: (context, state) {
          final Course course = state.extra as Course;
          return SingleCourseScreen(course: course);
        },
      ),
      GoRoute(
        path: "/add-assignment",
        name: "add assignment",
        builder: (context, state) {
          final Course course = state.extra as Course;
          return AddAssignmentPage(course: course);
        },
      ),
      GoRoute(
        path: "/add-note",
        name: "add note",
        builder: (context, state) {
          final Course course = state.extra as Course;
          return AddNotePage(course: course);
        },
      )
    ],
  );
}
