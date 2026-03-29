import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// SERVICES

class StudentsService {
  String getStudents() => "Students loaded";
}

class CourseService {
  String getCourses() => "Courses loaded";
}

class GradesService {
  String getGrades() => "Grades loaded";
}

// GLOBAL SERVICES INSTANCES

// StudentsService globalStudentsService = StudentsService();
// CourseService globalCourseService = CourseService();
// GradesService globalGradesService = GradesService();

// MAIN ---------------------------------------

void main() {
  runApp(
    MaterialApp(
      home: MultiProvider(
        providers: [
          Provider<StudentsService>(create: (_) => StudentsService()),
          Provider<CourseService>(create: (_) => CourseService()),
          Provider<GradesScreen>(create: (_) => GradesScreen()),
        ],
        child: App(),
      )
    )
  );
}

// UI
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("School App - Global Services")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          StudentsScreen(),
          CoursesScreen(),
          GradesScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Direct global access
    final data = context.read<StudentsService>().getStudents();

    return Text("StudentsScreen → $data");
  }
}

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.read<CourseService>().getCourses();

    return Text("CoursesScreen → $data");
  }
}

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Direct global access
    final grades = context.read<GradesService>().getGrades();
    final students = context.read<StudentsService>().getStudents();
    final courses = context.read<CourseService>().getCourses();

    return Text("GradesScreen → $grades for $students for $courses");
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Seeting");
  }
}
