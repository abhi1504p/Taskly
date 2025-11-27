import 'dart:convert';

import 'package:frontend/core/constant/constant.dart';
import 'package:frontend/features/home/repository/task_local_repository.dart';
import 'package:frontend/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteRepository {
  final taskLocalRepository=TaskLocalRepository();
  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String hexColor,
    required String token,
    required DateTime dueAt,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("${Constants.backendUri}/tasks"),
        headers: {"Content-Type": "application/json", "x-auth-token": token},

        body: jsonEncode({
          "title": title,
          "description": description,
          "hexColor": hexColor,
          "dueAt": dueAt.toIso8601String(),
        }),
      );
      if (res.statusCode != 201) {
        throw jsonDecode(res.body)["error"];
      }
      return TaskModel.fromMap(jsonDecode(res.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskModel>> getTask({required String token}) async {
    try {
      final res = await http.get(
        Uri.parse("${Constants.backendUri}/tasks"),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)["error"];
      }
      final listOfTask = jsonDecode(res.body);
      List<TaskModel> taskList = [];
      for (var elem in listOfTask) {

        taskList.add(TaskModel.fromMap(elem));
      }
      await taskLocalRepository.insertTasks(taskList);
      return taskList;
    } catch (e) {
      final tasks=await taskLocalRepository.getTask();
      if(tasks.isNotEmpty){
        return tasks;
      }
      rethrow;
    }
  }
}
