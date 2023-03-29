// ignore_for_file: unused_import, unnecessary_import, implementation_imports

import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class NewTasks extends StatefulWidget {
  const NewTasks({super.key});

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/note.jpg",
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 25),
            const Text(
              "Welcome To Notes App",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text("You Can Add Some Notes, view them, edit and delete"),
          ],
        ),
      ),
    );
  }
}
