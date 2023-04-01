// ignore_for_file: depend_on_referenced_packages, unnecessary_import, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/modules/Archive/archive_tasks.dart';
import 'package:todo_app/modules/Donetasks/done_tasks.dart';

import '../../modules/tasks/new_tasks.dart';

part 'homelayout_state.dart';

class HomelayoutCubit extends Cubit<HomelayoutState> {
  HomelayoutCubit() : super(HomelayoutInitial());

  static HomelayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasks(),
    Done(),
    Archive(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomelayoutChangeBottomNavBarState());
  }
}
