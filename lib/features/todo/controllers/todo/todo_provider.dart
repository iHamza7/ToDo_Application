import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/helpers/db_helper.dart';
import '../../../../common/models/task_model.dart';
import '../../../../common/utils/constants.dart';
part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<TaskModel> build() {
    return [];
  }

  void refresh() async {
    final data = await DbHelper.getItems();

    state = data.map((e) => TaskModel.fromJson(e)).toList();
  }

  void addItem(TaskModel task) async {
    await DbHelper.createItem(task);
    refresh();
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

  void updateItem(
    int id,
    String title,
    String description,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
  ) async {
    await DbHelper.updateItem(
        id, title, description, isCompleted, date, startTime, endTime);
    refresh();
  }

  Future<void> deleteTodo(int id) async {
    await DbHelper.deleteItem(id);
    refresh();
  }

  void markAsCompleted(
    int id,
    String title,
    String description,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
  ) async {
    await DbHelper.updateItem(
        id, title, description, 1, date, startTime, endTime);
    refresh();
  }

  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.toString().substring(0, 10);
  }

  List<String> last30Days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));
    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(TaskModel data) {
    bool? isCompleted;
    if (data.isCompleted == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }
    return isCompleted;
  }
}
