// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, unnecessary_import, avoid_print, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables, unused_import, duplicate_import

// import 'package:app_notes/shared/component/constans.dart';
// import 'dart:js';

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/shared/constans/constans.dart';

Widget defaultFormField({
  IconData prefixicon = Icons.title,
  required String label,
  required var controller,
  required String? Function(String?)? validator,
  Function()? ontap,
}) =>
    TextFormField(
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 25.h),
        label: Text(label),
        labelStyle: TextStyle(
          fontSize: 18.sp,
          color: Colors.grey,
        ),
        prefixIcon: Icon(prefixicon),
        // prefixIconColor: Colors.grey,
        border: OutlineInputBorder(),
        // focusedBorder: InputBorder.foucsBorder(borderSide:BorderSide(width: 1)),`
        filled: true,
        fillColor: Color.fromARGB(99, 189, 189, 189),
        // iconColor: Colors.red,
      ),
      validator: validator,
      onTap: ontap,
    );

Widget buildTaskItem(Map model) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0.r,
            child: Text("${model['time']}"),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              // mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "${model['title']}",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0.sp),
                ),
                Text(
                  "${model['date']}",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
