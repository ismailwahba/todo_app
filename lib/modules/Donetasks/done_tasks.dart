// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, unused_element, sized_box_for_whitespace

import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/shared/component/components.dart';

import '../../shared/constans/constans.dart';
// import 'package:todo_app/shared/component/components.dart';
// import 'package:todo_app/shared/constans/constans.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  // List<NoteModel> notesModels = [];

  Sqldb sqldb = Sqldb();

  @override
  void initState() {
    // sqldb.insertData(title: , time: time, date: date)
    sqldb.getAllNotesTable().then((value) {
      setState(() {
        notes = value;
      });
    });
    // notesModels = response.cast<NoteModel>();
    // return response;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(notes[index]),
            separatorBuilder: (context, index) =>
                Container(height: 1.0, color: Colors.black),
            itemCount: notes.length));
  }
  // return Center(child: CircularProgressIndicator());
  // })
  // ],
  // )));
}
