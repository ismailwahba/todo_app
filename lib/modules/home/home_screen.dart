// ignore_for_file: unused_import, implementation_imports, unnecessary_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, avoid_print, must_be_immutable, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, unused_element, prefer_is_empty, annotate_overrides, override_on_non_overriding_member, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/modules/Archive/archive_tasks.dart';
import 'package:todo_app/modules/Donetasks/done_tasks.dart';
import 'package:todo_app/modules/tasks/new_tasks.dart';
import 'package:todo_app/shared/constans/constans.dart';

import '../../shared/component/components.dart';
import '../../shared/cubit/homelayout_cubit.dart';

class Todo extends StatelessWidget {
  @override
  Sqldb sqldb = Sqldb();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  bool isBottomShown = false;
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomelayoutCubit(),
      child: BlocConsumer<HomelayoutCubit, HomelayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomelayoutCubit cubit = HomelayoutCubit.get(context);

          return Scaffold(
            body: HomelayoutCubit.get(context).screens[cubit.currentIndex],
            key: scaffoldKey,
            appBar: AppBar(
              title:
                  Text(cubit.titles[HomelayoutCubit.get(context).currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Done()));
                        // setState(() {
                        //   isBottomShown = false;
                        //   fabIcon = Icons.edit;
                        //   notes = value;
                        // });
                      });
                    });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
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
                                    height: 15.h,
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
                                          print(
                                              value.format(context).toString());
                                        });
                                      }),
                                      controller: timeController,
                                      label: 'Task Time',
                                      prefixicon: Icons.watch_later_outlined),
                                  SizedBox(
                                    height: 15.h,
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
                                                lastDate: DateTime.parse(
                                                    "2023-08-25"))
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
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                  });
                  // setState(() {
                  //   fabIcon = Icons.add;
                  // });
                  isBottomShown = true;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
