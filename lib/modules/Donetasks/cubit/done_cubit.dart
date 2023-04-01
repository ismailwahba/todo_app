// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'done_state.dart';

class DoneCubit extends Cubit<DoneState> {
  DoneCubit() : super(DoneInitial());
}
