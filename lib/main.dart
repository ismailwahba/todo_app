// ignore_for_file: duplicate_import

import 'package:bloc/bloc.dart';
import 'package:todo_app/root/app_root.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/root/app_root.dart';
import 'package:todo_app/root/app_root.dart';
import 'package:todo_app/shared/constans.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}
