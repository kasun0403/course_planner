import 'package:course_planner/pages/home_page.dart';
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
        )
      ]);
}
