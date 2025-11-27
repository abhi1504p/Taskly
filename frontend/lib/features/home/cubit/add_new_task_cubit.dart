import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:frontend/core/widget/app_color.dart';
import 'package:frontend/features/home/repository/task_local_repository.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';

import 'package:frontend/models/task_model.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  AddNewTaskCubit() : super(AddNewTaskInitial());

  final taskRemoteRepository = TaskRemoteRepository();
  final taskLocalRepository= TaskLocalRepository();

  Future<void> createNewTask({
    required String title,
    required String description,
    required Color color,
    required String token,
    required DateTime dueAt,
  }) async {
    try {
      emit(AddNewTaskLoading());
      final taskModel = await taskRemoteRepository.createTask(
        title: title,
        description: description,
        hexColor: rgnToHex(color),
        token: token,
        dueAt: dueAt,
      );
      await taskLocalRepository.insertTask(taskModel);
      emit(AddNewTaskSuccess(taskModel));
    } catch (e) {
      emit(AddNewTaskError(e.toString()));
    }
  }

  Future<void> getAllTask({required String token}) async {
    try {
      emit(AddNewTaskLoading());
      final tasks = await taskRemoteRepository.getTask(token: token);
      emit(GetTaskSuccess(tasks));
    } catch (e) {
      emit(AddNewTaskError(e.toString()));
    }
  }
}
