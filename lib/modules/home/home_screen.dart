// ignore_for_file: unused_import, implementation_imports, unnecessary_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, avoid_print, must_be_immutable, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, unused_element, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/modules/Archive/archive_tasks.dart';
import 'package:todo_app/modules/Donetasks/done_tasks.dart';
import 'package:todo_app/modules/tasks/new_tasks.dart';
import 'package:todo_app/shared/constans/constans.dart';

import '../../shared/component/components.dart';

class Todo extends StatefulWidget {
  Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  Sqldb sqldb = Sqldb();
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> screens = [
    NewTasks(),
    Done(),
    Archive(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  var formKey = GlobalKey<FormState>();
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  bool isBottomShown = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: "Done"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "Archive"),
          ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(fabIcon),
        onPressed: () {
          if (isBottomShown) {
            if (formKey.currentState!.validate()) {
              sqldb
                  .insertData(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text)
                  .then((value) {
                sqldb.getAllNotesTable().then((value) {
                  // Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Done()));
                  setState(() {
                    isBottomShown = false;
                    fabIcon = Icons.edit;
                    notes = value;
                  });
                });
              });
            }
          } else {
            scaffoldKey.currentState!
                .showBottomSheet((context) => Container(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              label: "Task Title",
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "task Title Must not be Empty";
                                }
                              },
                              controller: titleController,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "task Time Must not be Empty";
                                  }
                                },
                                ontap: (() {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                    print(value.format(context).toString());
                                  });
                                }),
                                controller: timeController,
                                label: 'Task Time',
                                prefixicon: Icons.watch_later_outlined),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                // controller:dateController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "task Date Must not be Empty";
                                  }
                                },
                                ontap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse("2023-08-25"))
                                      .then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                controller: dateController,
                                label: 'Task Date',
                                prefixicon: Icons.date_range_outlined)
                          ],
                        ),
                      ),
                    ))
                .closed
                .then((value) {
              isBottomShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            setState(() {
              fabIcon = Icons.add;
            });
            isBottomShown = true;
          }
        },
      ),
    );
  }
}
