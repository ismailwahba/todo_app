// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, unused_element, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/shared/component/components.dart';

import '../../shared/constans/constans.dart';
// import 'package:todo_app/shared/component/components.dart';
// import 'package:todo_app/shared/constans/constans.dart';

class Done extends StatelessWidget {
  

   @override
  Widget build(BuildContext context) {
//       getAllNotesTable().then((value) {
     
//         notes = value;
    
// }
    return Scaffold(
      // appBar:AppBar(title:,),
        body: ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(notes[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Container(
                    height: 1.0.h,
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
            itemCount: notes.length));
  }
}


  

  

  
